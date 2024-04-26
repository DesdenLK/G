#include "ModelInfo1.h"
#include "glwidget.h"

void ModelInfo1::computeInfo() 
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

void ModelInfo1::printInfo()
{
	cout << "Number of loaded objects: " << ObjectCount << endl;
	cout << "Number of polygons: " << faceCount << endl;
	cout << "Number of vertices: " << vertexCount << endl;
	cout << "Percentage of triangles: " << (triangleCount / faceCount) * 100 << endl;
}

void ModelInfo1::onPluginLoad()
{
	computeInfo();
}

void ModelInfo1::preFrame()
{
	
}

void ModelInfo1::postFrame()
{
	printInfo();
}

void ModelInfo1::onObjectAdd()
{
	computeInfo();
}

bool ModelInfo1::drawScene()
{
	return false; // return true only if implemented
}

bool ModelInfo1::drawObject(int)
{
	return false; // return true only if implemented
}

bool ModelInfo1::paintGL()
{
	return false; // return true only if implemented
}

void ModelInfo1::keyPressEvent(QKeyEvent *)
{
	
}

void ModelInfo1::mouseMoveEvent(QMouseEvent *)
{
	
}

