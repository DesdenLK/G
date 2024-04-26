#include "Animate_Vertices.h"
#include "glwidget.h"

void Animate_Vertices::onPluginLoad()
{
	elapsedTimer.start();
	vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
    vs->compileSourceFile("../../../shaders/LAB1/animate-vertices1/animate-vertices1.vert");
    cout << "VS log:" << vs->log().toStdString() << endl;

	fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
    fs->compileSourceFile("../../../shaders/LAB1/animate-vertices1/animate-vertices1.frag");
    cout << "FS log:" << fs->log().toStdString() << endl;

    program = new QOpenGLShaderProgram(this);
    program->addShader(vs);
    program->addShader(fs);
    program->link();
    cout << "Link log:" << program->log().toStdString() << endl;	
}

void Animate_Vertices::preFrame()
{
	program->bind();
    program->setUniformValue("time", float(elapsedTimer.elapsed() / 1000.0f));
    QMatrix4x4 MVP = camera()->projectionMatrix() * camera()->viewMatrix();
    program->setUniformValue("modelViewProjectionMatrix", MVP); 
	QMatrix3x3 N = camera()->viewMatrix().normalMatrix();
	program->setUniformValue("normalMatrix", N);

}

void Animate_Vertices::postFrame()
{
	program->release();
}

void Animate_Vertices::onObjectAdd()
{
	
}

bool Animate_Vertices::drawScene()
{
	return false; // return true only if implemented
}

bool Animate_Vertices::drawObject(int)
{
	return false; // return true only if implemented
}

bool Animate_Vertices::paintGL()
{
	return false; // return true only if implemented
}

void Animate_Vertices::keyPressEvent(QKeyEvent *)
{
	
}

void Animate_Vertices::mouseMoveEvent(QMouseEvent *)
{
	
}

