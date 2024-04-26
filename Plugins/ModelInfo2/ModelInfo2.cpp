#include "ModelInfo2.h"
#include "glwidget.h"

void ModelInfo2::computeInfo() 
{
	Scene *scr = scene();
	const vector<Object> & obj = scr -> objects();
	ObjectCount = obj.size();

	vertexCount = 0;
	faceCount = 0;
	triangleCount = 0;

	for (int i = 0; i < ObjectCount; ++i) {
		const Object & object = obj[i];
		const vector<Vertex> & vertices = object.vertices();
		const vector<Face> & faces = object.faces();
		vertexCount += vertices.size();
		faceCount += faces.size();

		for (uint j = 0; j < faces.size(); ++j) {
			if (faces[j].numVertices() == 3) ++triangleCount;
		}

	}
}

void ModelInfo2::printInfo()
{
	cout << "Number of loaded objects: " << ObjectCount << endl;
	cout << "Number of polygons: " << faceCount << endl;
	cout << "Number of vertices: " << vertexCount << endl;
	cout << "Percentage of triangles: " << (triangleCount / faceCount) * 100 << endl;
}

void ModelInfo2::ShowInfo()
{
QFont font;
  int size = 20;
  font.setPixelSize(size);
  painter.begin(glwidget());
  painter.setFont(font);
  painter.drawText(4, 1 * size, QString("Number of loaded objects: ")
  + QString::number(ObjectCount));
  painter.drawText(4, 2.5 * size, QString("Number of vertices: ")
  + QString::number(vertexCount));
  painter.drawText(4, 4 * size, QString("Number of polygons: ")
  + QString::number(faceCount));
  painter.drawText(4, 5.5 * size, QString("Number of triangles: ")
  + QString::number(triangleCount));
 
  painter.end();
}

void ModelInfo2::onPluginLoad()
{
	computeInfo();
}

void ModelInfo2::preFrame()
{
	
}

void ModelInfo2::postFrame()
{
	printInfo();
	ShowInfo();
}

void ModelInfo2::onObjectAdd()
{
	computeInfo();
}

bool ModelInfo2::drawScene()
{
	return false; // return true only if implemented
}

bool ModelInfo2::drawObject(int)
{
	return false; // return true only if implemented
}

bool ModelInfo2::paintGL()
{
	return false; // return true only if implemented
}

void ModelInfo2::keyPressEvent(QKeyEvent *)
{
	
}

void ModelInfo2::mouseMoveEvent(QMouseEvent *)
{
	
}

