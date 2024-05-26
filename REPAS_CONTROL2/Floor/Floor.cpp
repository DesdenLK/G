#include "Floor.h"
#include "glwidget.h"

float Floor::computeLambda(const Object & object) {
	const vector <Vertex> & vertices = object.vertices();
	float usableObjectArea = 0;
	float objectArea = 0;
	for (const Face & face : object.faces()) {
		float dot = Vector::dotProduct(face.normal(), Vector(0,0,1));
		const Point & v0 = vertices[face.vertexIndex(0)].coord();
		const Point & v1 = vertices[face.vertexIndex(1)].coord();
		const Point & v2 = vertices[face.vertexIndex(2)].coord();
		Vector v = v1 - v0;
		Vector u = v2 - v0;
		float area = Vector::crossProduct(u,v).length() / 2;
		objectArea += area;
		if (dot > 0.7) usableObjectArea += area;
	}
	return usableObjectArea/objectArea;
}
void Floor::linkshaders() {
	vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
	vs->compileSourceFile("floor.vert");
	cout << "VS log:" << vs->log().toStdString() << endl;

	fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
	fs->compileSourceFile("floor.frag");
	cout << "FS log:" << fs->log().toStdString() << endl;

	program = new QOpenGLShaderProgram(this);
	program->addShader(vs);
	program->addShader(fs);
	program->link();
	cout << "Link log:" << program->log().toStdString() << endl;
}

void Floor::onPluginLoad()
{
	linkshaders();
	if (scene() -> objects().size() > 0) {
		lambda = computeLambda(scene() -> objects()[0]);
		cout << "TERRA: " << lambda << endl;
	}	
}

void Floor::preFrame()
{
	program->bind();
    QMatrix4x4 MVP = camera()->projectionMatrix() * camera()->viewMatrix();
    program->setUniformValue("modelViewProjectionMatrix", MVP);
    QMatrix3x3 N = camera()->viewMatrix().normalMatrix();
    program->setUniformValue("normalMatrix", N);
    program->setUniformValue("lambda", lambda);	
}

void Floor::postFrame()
{

}

void Floor::onObjectAdd()
{
	if (scene() -> objects().size() > 0) {
		lambda = computeLambda(scene() -> objects()[0]);
		cout << "TERRA: " << lambda << endl;
	}
}

bool Floor::drawScene()
{
	return false; // return true only if implemented
}

bool Floor::drawObject(int)
{
	return false; // return true only if implemented
}

bool Floor::paintGL()
{
	return false; // return true only if implemented
}

void Floor::keyPressEvent(QKeyEvent *)
{
	
}

void Floor::mouseMoveEvent(QMouseEvent *)
{
	
}

