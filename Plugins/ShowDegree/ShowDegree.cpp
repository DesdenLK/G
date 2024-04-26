#include "ShowDegree.h"
#include "glwidget.h"


float ShowDegree::averageDegree(const Object& obj)
{
	int n = obj.vertices().size();
	int m = 0;
	for (const Face & face: obj.faces()) {
		m += face.numVertices();
	}

	return m / float(n);
}

void ShowDegree::ShowD()
{
  QFont font;
  int size = 20;
  font.setPixelSize(size);
  painter.begin(glwidget());
  painter.setFont(font);
  painter.drawText(1, 1*size, QString::number(degree));    
  painter.end();
}

void ShowDegree::onPluginLoad()
{
	degree = averageDegree(scene() -> objects()[0]);
}

void ShowDegree::preFrame()
{
	
}

void ShowDegree::postFrame()
{
	ShowD();
}

void ShowDegree::onObjectAdd()
{
	degree = averageDegree(scene() -> objects()[0]);
}

bool ShowDegree::drawScene()
{
	return false; // return true only if implemented
}

bool ShowDegree::drawObject(int)
{
	return false; // return true only if implemented
}

bool ShowDegree::paintGL()
{
	return false; // return true only if implemented
}

void ShowDegree::keyPressEvent(QKeyEvent *)
{
	
}

void ShowDegree::mouseMoveEvent(QMouseEvent *)
{
	
}

