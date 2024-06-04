#include "Floor_REPAS.h"
#include "glwidget.h"


void Floor_REPAS::linkshaders() {
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

float Floor_REPAS::computeLambda(const Object & obj) {
	float areaTotal = 0;
	float usbableArea = 0;
	const vector<Face> & faces = obj.faces();

	const vector<Vertex> vertices = obj.vertices();

	for (uint i = 0; i < faces.size(); ++i) {
		const Point & A =  vertices[faces[i].vertexIndex(0)].coord();
		const Point & B =  vertices[faces[i].vertexIndex(1)].coord();
		const Point & C =  vertices[faces[i].vertexIndex(2)].coord();

		Vector AB = B - A;
		Vector AC = C - A;

		float area = Vector::crossProduct(AB, AC).length() / 2;
		areaTotal += area;

		float usable = Vector::dotProduct(faces[i].normal(), Vector(0,0,1));
		if (usable > 0.7) usbableArea += area;
	}

	return usbableArea / areaTotal;
}



void Floor_REPAS::onPluginLoad()
{
	linkshaders();
	if (scene() -> objects().size() > 0) {
		lambda = computeLambda(scene() -> objects()[0]);
	}
}

void Floor_REPAS::preFrame()
{
	program -> bind();
	QMatrix4x4 MVP = camera() -> projectionMatrix() * camera() -> viewMatrix();
	program -> setUniformValue("modelViewProjectionMatrix", MVP);
	program -> setUniformValue("lambda", lambda);
	program -> setUniformValue("normalMatrix", camera() -> viewMatrix().normalMatrix());
}

void Floor_REPAS::postFrame()
{
	
}

void Floor_REPAS::onObjectAdd()
{
	if (scene() -> objects().size() > 0) {
		lambda = computeLambda(scene() -> objects()[0]);
	}
}

bool Floor_REPAS::drawScene()
{
	return false; // return true only if implemented
}

bool Floor_REPAS::drawObject(int)
{
	return false; // return true only if implemented
}

bool Floor_REPAS::paintGL()
{
	return false; // return true only if implemented
}

void Floor_REPAS::keyPressEvent(QKeyEvent *)
{
	
}

void Floor_REPAS::mouseMoveEvent(QMouseEvent *)
{
	
}

