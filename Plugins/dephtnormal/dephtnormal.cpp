#include "dephtnormal.h"
#include "glwidget.h"

void Dephtnormal::linkDepthShaders()
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

void Dephtnormal::linkNormalShaders()
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

void Dephtnormal::onPluginLoad()
{
	linkDepthShaders();
	linkNormalShaders();
}

void Dephtnormal::preFrame()
{
	
}

void Dephtnormal::postFrame()
{
	
}

void Dephtnormal::onObjectAdd()
{
	
}

bool Dephtnormal::drawScene()
{
	return false; // return true only if implemented
}

bool Dephtnormal::drawObject(int)
{
	return false; // return true only if implemented
}

bool Dephtnormal::paintGL()
{
	GLWidget & g = *glwidget();
	g.makeCurrent();

	g.glClearColor(0,0,0,0);

	float originalRatio = g.width() / g.height();
	float half = g.width() / 2.0;

	camera() -> setAspectRatio(originalRatio / 2.0);
	glViewport(0,0,half, g.height());

	
	depthProgram -> bind();
	QMatrix4x4 MVP = camera() -> projectionMatrix() * camera() -> viewMatrix();
	depthProgram -> setUniformValue("modelViewProjectionMatrix", MVP);

	if (drawPlugin()) drawPlugin()->drawScene();
	

	glViewport(half,0,half, g.height());
	normalShaderProgram -> bind();
	QMatrix4x4 MVP2 = camera() -> projectionMatrix() * camera() -> viewMatrix();
	normalShaderProgram -> setUniformValue("modelViewProjectionMatrix", MVP2);

	if (drawPlugin()) drawPlugin()->drawScene();
	return true; // return true only if implemented
}

void Dephtnormal::keyPressEvent(QKeyEvent *)
{
	
}

void Dephtnormal::mouseMoveEvent(QMouseEvent *)
{
	
}

