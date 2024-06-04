#include "ShowDegree_REPAS.h"
#include "glwidget.h"

float ShowDegree_REPAS::computeInfo(const Object & obj) 
{
	int n = obj.vertices().size();
	int m = 0;
	for (const Face & face: obj.faces()) {
		m += face.numVertices();
	}
	return m / float(n);
}

void ShowDegree_REPAS::printInfo()
{
	cout << "Number of loaded objects: " << ObjectCount << endl;
	cout << "Number of polygons: " << faceCount << endl;
	cout << "Number of vertices: " << vertexCount << endl;
	cout << "Percentage of triangles: " << (triangleCount / faceCount) * 100 << endl;
}

void ShowDegree_REPAS::ShowInfo()
{
  QFont font;
  int size = 20;
  font.setPixelSize(size);
  painter.begin(glwidget());
  painter.setFont(font);
  painter.drawText(4, 1 * size, QString::number(degree));
 
  painter.end();
}

void ShowDegree_REPAS::onPluginLoad()
{
	degree = computeInfo(scene() -> objects()[0]);
}

void ShowDegree_REPAS::preFrame()
{
	
}

void ShowDegree_REPAS::postFrame()
{
	ShowInfo();
}

void ShowDegree_REPAS::onObjectAdd()
{
	degree = computeInfo(scene() -> objects()[0]);
}

bool ShowDegree_REPAS::drawScene()
{
	return false; // return true only if implemented
}

bool ShowDegree_REPAS::drawObject(int)
{
	return false; // return true only if implemented
}

bool ShowDegree_REPAS::paintGL()
{
	return false; // return true only if implemented
}

void ShowDegree_REPAS::keyPressEvent(QKeyEvent *)
{
	
}

void ShowDegree_REPAS::mouseMoveEvent(QMouseEvent *)
{
	
}

