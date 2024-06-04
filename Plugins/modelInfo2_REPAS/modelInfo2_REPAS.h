#ifndef _MODELINFO2_REPAS_H
#define _MODELINFO2_REPAS_H

#include "plugin.h" 
#include <QPainter>

class ModelInfo2_REPAS: public QObject, public Plugin
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
  private:
  int objectCount;
  int polygonCount;
  int vertexCount;
  int triangleCount;
  QPainter painter;
  void computeInfo();
  void printInfo();
};

#endif
