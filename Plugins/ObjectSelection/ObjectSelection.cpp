#include "ObjectSelection.h"
#include "glwidget.h"


void ObjectSelection::linkBoxShaders()
{
	boxVertexShader = new QOpenGLShader(QOpenGLShader::Vertex, this);
	boxVertexShader->compileSourceFile("Box.vert");
	cout << "VS log:" << boxVertexShader->log().toStdString() << endl;

	boxFragmentShader = new QOpenGLShader(QOpenGLShader::Fragment, this);
	boxFragmentShader->compileSourceFile("Box.frag");
	cout << "FS log:" << boxFragmentShader->log().toStdString() << endl;

	boxShaderProgram = new QOpenGLShaderProgram(this);
	boxShaderProgram->addShader(boxVertexShader);
	boxShaderProgram->addShader(boxFragmentShader);
	boxShaderProgram->link();
	cout << "Link log:" << boxShaderProgram->log().toStdString() << endl;
}

void ObjectSelection::linkSelectionShaders()
{
	selectionVertexShader = new QOpenGLShader(QOpenGLShader::Vertex, this);
	selectionVertexShader->compileSourceFile("Selection.vert");
	cout << "VS log (selection):" << selectionVertexShader->log().toStdString() << endl;

	selectionFragmentShader = new QOpenGLShader(QOpenGLShader::Fragment, this);
	selectionFragmentShader->compileSourceFile("Selection.frag");
	cout << "FS log (selection):" << selectionFragmentShader->log().toStdString() << endl;

	selectionShaderProgram = new QOpenGLShaderProgram(this);
	selectionShaderProgram->addShader(selectionVertexShader);
	selectionShaderProgram->addShader(selectionFragmentShader);
	selectionShaderProgram->link();
	cout << "Link log (selection):" << selectionShaderProgram->log().toStdString() << endl;
}

void ObjectSelection::createBox(GLWidget & widget)
{
	widget.glGenVertexArrays(1, &boxId);
	widget.glBindVertexArray(boxId);
	float coordinates[] = {
		1, 1, 0,	 0, 1, 0,
		1, 0, 0,	 0, 0, 0,
		0, 0, 1,	 0, 1, 0,
		0, 1, 1,	 1, 1, 0,
		1, 1, 1,	 1, 0, 0,
		1, 0, 1,	 0, 0, 1,
		1, 1, 1,	 0, 1, 1
	};
	GLuint VBO_coordinates;
	widget.glGenBuffers(1, &VBO_coordinates);
	widget.glBindBuffer(GL_ARRAY_BUFFER, VBO_coordinates);
	widget.glBufferData(GL_ARRAY_BUFFER, sizeof(coordinates), coordinates, GL_STATIC_DRAW);
	widget.glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, 0);
	widget.glEnableVertexAttribArray(0);
	widget.glBindVertexArray(0);

}

void ObjectSelection::drawBox(GLWidget & widget, const Box & box)
{
	QMatrix4x4 MVP = widget.camera()->projectionMatrix() * widget.camera()->viewMatrix();
	const Point & translate = box.min();
	const Point & scale = box.max() - box.min();
	GLint polygonMode;
	boxShaderProgram->bind();
	boxShaderProgram->setUniformValue("modelViewProjectionMatrix", MVP);
	boxShaderProgram->setUniformValue("translate", translate);
	boxShaderProgram->setUniformValue("scale", scale);
	boxShaderProgram->setUniformValue("color", QVector4D(0.0f, 0.0f, 0.0f, 1.0f));
	widget.glGetIntegerv(GL_POLYGON_MODE, &polygonMode);
	widget.glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
	widget.glBindVertexArray(boxId);
	widget.glDrawArrays(GL_TRIANGLE_STRIP, 0, 14);
	widget.glBindVertexArray(0);
	widget.glPolygonMode(GL_FRONT_AND_BACK, polygonMode);
	widget.defaultProgram()->bind();
}


void ObjectSelection::onPluginLoad()
{
	GLWidget & widget = * glwidget();
	widget.makeCurrent();
	linkBoxShaders();
	linkSelectionShaders();
	createBox(widget);
}

void ObjectSelection::preFrame()
{

}

void ObjectSelection::postFrame()
{
	GLWidget & widget = * glwidget();
	widget.makeCurrent();
	int id = widget.scene()->selectedObject();
	if (id >= 0) drawBox(widget, widget.scene()->objects()[id].boundingBox());
	
}

void ObjectSelection::onObjectAdd()
{
	
}

bool ObjectSelection::drawScene()
{
	return false; // return true only if implemented
}

bool ObjectSelection::drawObject(int)
{
	return false; // return true only if implemented
}

bool ObjectSelection::paintGL()
{
	return false; // return true only if implemented
}

void ObjectSelection::keyPressEvent(QKeyEvent * event)
{
	if (Qt::Key_0 <= event->key() && event->key() <= Qt::Key_9) {
		GLWidget & widget = * glwidget();
		widget.makeCurrent();
		int id = event->key() - Qt::Key_0;
		id = ((unsigned int) id) < widget.scene()->objects().size() ? id : -1;
		widget.scene()->setSelectedObject(id);
		widget.update();
	}
}

void ObjectSelection::mouseReleaseEvent(QMouseEvent* e)
{
	
    // a)
    if(!(e->button() & Qt::LeftButton)) return;
    if((e->modifiers() & (Qt::ShiftModifier))) return;
    if(!(e->modifiers() & (Qt::ControlModifier))) return;
    GLWidget &g = *glwidget();
    g.makeCurrent();
    
    // b)
    g.glClearColor(0,0,0,0);
    g.glClear(GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT);
    

    // c)
    selectionShaderProgram->bind();
    
    // d)
	
    QMatrix4x4 MVP = camera()->projectionMatrix() * camera()->viewMatrix();
    selectionShaderProgram->setUniformValue("modelViewProjectionMatrix", MVP); 
    
    
    // e)
    for(unsigned int i = 0; i < scene()->objects().size(); ++i)
    {
        GLubyte color[4];
        color[0] = i + 1;
        color[1] = color[2] = 0;
        selectionShaderProgram -> setUniformValue("color", QVector4D(color[0]/255.0,color[1]/255.,color[2]/255.,1.0));
        drawPlugin() -> drawObject(i);
    }
    
    // f)
	
    int x = e -> x();
    int y = glwidget() -> height() - e->y();
    GLubyte read[4];
    glReadPixels(x,y,1,1,GL_RGBA,GL_UNSIGNED_BYTE,read); 
    
    // g)
    if(read[0] != 0) scene()->setSelectedObject(read[0] - 1);
    
    // h)
	g.defaultProgram()->bind();
    g.update();
	

}

