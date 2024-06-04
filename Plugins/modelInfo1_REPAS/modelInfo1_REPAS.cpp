#include "modelInfo1_REPAS.h"
#include "glwidget.h"

void ModelInfo1_REPAS::computeInfo() {
	Scene *scr = scene();
	const vector<Object> & obj = scr -> objects();
	vertexCount = 0;
	triangleCount = 0;
	polygonCount = 0;

	objectCount = obj.size();

	for (int i = 0; i < obj.size(); ++i) {
		const Object & object = obj[i];
		vertexCount += object.vertices().size();
		polygonCount += object.faces().size();

		const vector<Face> & faces = object.faces();
		for (uint j = 0; j < object.faces().size(); ++j) {
			if (faces[j].numVertices() == 3) ++triangleCount;
		}
	}
}

void ModelInfo1_REPAS::printInfo() {
	cout << "Number of loaded objects: " << objectCount << endl;
	cout << "Number of polygons: " << polygonCount << endl;
	cout << "Number of vertices: " << vertexCount << endl;
	cout << "Percentage of triangles: " << (triangleCount / polygonCount) * 100 << endl;
}

void ModelInfo1_REPAS::onPluginLoad()
{
	computeInfo();	
}

void ModelInfo1_REPAS::preFrame()
{
	
}

void ModelInfo1_REPAS::postFrame()
{
	printInfo();	
}

void ModelInfo1_REPAS::onObjectAdd()
{
	computeInfo();
}

bool ModelInfo1_REPAS::drawScene()
{
	return false; // return true only if implemented
}

bool ModelInfo1_REPAS::drawObject(int)
{
	return false; // return true only if implemented
}

bool ModelInfo1_REPAS::paintGL()
{
	return false; // return true only if implemented
}

void ModelInfo1_REPAS::keyPressEvent(QKeyEvent *)
{
	
}

void ModelInfo1_REPAS::mouseMoveEvent(QMouseEvent *)
{
	
}

