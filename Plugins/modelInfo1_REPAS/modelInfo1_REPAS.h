#ifndef _MODELINFO1_REPAS_H
#define _MODELINFO1_REPAS_H

#include "plugin.h" 

class ModelInfo1_REPAS: public QObject, public Plugin
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
  void computeInfo();
  void printInfo();
};

#endif
