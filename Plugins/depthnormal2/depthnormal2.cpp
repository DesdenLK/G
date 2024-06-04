#include "depthnormal2.h"
#include "glwidget.h"

void Depthnormal2::linkDepthShaders()
{
	dephtVertexShader = new QOpenGLShader(QOpenGLShader::Vertex, this);
	dephtVertexShader->compileSourceFile("depth.vert");
	cout << "VS log:" << dephtVertexShader->log().toStdString() << endl;

	depthFragmentShader = new QOpenGLShader(QOpenGLShader::Fragment, this);
	depthFragmentShader->compileSourceFile("depth.frag");
	cout << "FS log:" << depthFragmentShader->log().toStdString() << endl;

	depthProgram = new QOpenGLShaderProgram(this);
	depthProgram->addShader(dephtVertexShader);
	depthProgram->addShader(depthFragmentShader);
	depthProgram->link();
	cout << "Link log:" << depthProgram->log().toStdString() << endl;
}

void Depthnormal2::linkNormalShaders()
{
	normalVertexShader = new QOpenGLShader(QOpenGLShader::Vertex, this);
	normalVertexShader->compileSourceFile("normal.vert");
	cout << "VS log:" << normalVertexShader->log().toStdString() << endl;

	normalFragmentShader = new QOpenGLShader(QOpenGLShader::Fragment, this);
	normalFragmentShader->compileSourceFile("normal.frag");
	cout << "FS log:" << normalFragmentShader->log().toStdString() << endl;

	normalShaderProgram = new QOpenGLShaderProgram(this);
	normalShaderProgram->addShader(normalVertexShader);
	normalShaderProgram->addShader(normalFragmentShader);
	normalShaderProgram->link();
	cout << "Link log:" << normalShaderProgram->log().toStdString() << endl;
}

void Depthnormal2::onPluginLoad()
{
	linkNormalShaders();
	linkDepthShaders();
}

void Depthnormal2::preFrame()
{
	
}

void Depthnormal2::postFrame()
{
	
}

void Depthnormal2::onObjectAdd()
{
	
}

bool Depthnormal2::drawScene()
{
	return false; // return true only if implemented
}

bool Depthnormal2::drawObject(int)
{
	return false; // return true only if implemented
}

bool Depthnormal2::paintGL()
{
	GLWidget & g = *glwidget();
	g.makeCurrent();

	g.glClearColor(0,0,0,0);
	float originalRatio = g.width() / g.height();
	camera() -> setAspectRatio(originalRatio / 2);

	glViewport(0, 0, g.width()/2, g.height());

	depthProgram -> bind();
	depthProgram -> setUniformValue("modelViewProjectionMatrix", camera() -> projectionMatrix() * camera() -> viewMatrix());

	if (drawPlugin()) drawPlugin()->drawScene();

	glViewport(g.width()/2, 0, g.width()/2, g.height());

	normalShaderProgram -> bind();
	normalShaderProgram -> setUniformValue("modelViewProjectionMatrix", camera() -> projectionMatrix() * camera() -> viewMatrix());

	if (drawPlugin()) drawPlugin()->drawScene();

	return true; // return true only if implemented
}

void Depthnormal2::keyPressEvent(QKeyEvent *)
{
	
}

void Depthnormal2::mouseMoveEvent(QMouseEvent *)
{
	
}

