#include "FPS.h"
#include "glwidget.h"


void FPS::updateFPS() {
  cout << frames << endl;
  QFont font;
  int size = 20;
  font.setPixelSize(size);
  painter.begin(glwidget());
  painter.setFont(font);
  painter.drawText(1, 1*size, QString::number(frames));    
  painter.end();
  frames = 0;
}
void FPS::onPluginLoad()
{
	frames = 0;
	connect(&timer, SIGNAL(timeout()), this, SLOT(updateFPS()));
	timer.setInterval(1000);
	timer.start();
}

void FPS::preFrame()
{
	frames += 1;
}

void FPS::postFrame()
{
	
}

void FPS::onObjectAdd()
{
	
}

bool FPS::drawScene()
{
	return false; // return true only if implemented
}

bool FPS::drawObject(int)
{
	return false; // return true only if implemented
}

bool FPS::paintGL()
{
	return false; // return true only if implemented
}

void FPS::keyPressEvent(QKeyEvent *)
{
	
}

void FPS::mouseMoveEvent(QMouseEvent *)
{
	
}

