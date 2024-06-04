#include "modelInfo2_REPAS.h"
#include "glwidget.h"

void ModelInfo2_REPAS::computeInfo() {
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

void ModelInfo2_REPAS::printInfo() {
	QFont font;
	int size = 20;
	font.setPixelSize(size);
	painter.begin(glwidget());
	painter.setFont(font);
	painter.drawText(4, 1 * size, QString("Number of loaded objects: ")
	+ QString::number(objectCount));
	painter.drawText(4, 2.5 * size, QString("Number of vertices: ")
	+ QString::number(vertexCount));
	painter.drawText(4, 4 * size, QString("Number of polygons: ")
	+ QString::number(polygonCount));
	painter.drawText(4, 5.5 * size, QString("Number of triangles: ")
	+ QString::number(triangleCount));

	painter.end();
}

void ModelInfo2_REPAS::onPluginLoad()
{
	computeInfo();	
}

void ModelInfo2_REPAS::preFrame()
{
	
}

void ModelInfo2_REPAS::postFrame()
{
	printInfo();	
}

void ModelInfo2_REPAS::onObjectAdd()
{
	computeInfo();
}

bool ModelInfo2_REPAS::drawScene()
{
	return false; // return true only if implemented
}

bool ModelInfo2_REPAS::drawObject(int)
{
	return false; // return true only if implemented
}

bool ModelInfo2_REPAS::paintGL()
{
	return false; // return true only if implemented
}

void ModelInfo2_REPAS::keyPressEvent(QKeyEvent *)
{
	
}

void ModelInfo2_REPAS::mouseMoveEvent(QMouseEvent *)
{
	
}

