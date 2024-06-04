#ifndef _FPS_H
#define _FPS_H

#include "plugin.h" 
#include <QTimer>
#include <QElapsedTimer>
#include <QPainter>

class FPS: public QObject, public Plugin
{
	Q_OBJECT
	Q_PLUGIN_METADATA(IID "Plugin") 
	Q_INTERFACES(Plugin)

  public:
	 void onPluginLoad();
	 void preFrame();
	 void postFrame();

	 void onObjectAdd();
	 bool drawScene();
	 bool drawObject(int);

	 bool paintGL();

	 void keyPressEvent(QKeyEvent *);
	 void mouseMoveEvent(QMouseEvent *);
  
  public slots:
	void updateFPS();
  private:
    QTimer timer;
	QPainter painter;
	int frames;
};

#endif
