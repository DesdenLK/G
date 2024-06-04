#ifndef _SHOWDEGREE_REPAS_H
#define _SHOWDEGREE_REPAS_H

#include "plugin.h" 
#include <QPainter>

class ShowDegree_REPAS: public QObject, public Plugin
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
	 int ObjectCount;
	 int vertexCount;
	 int faceCount;
	 int triangleCount;
	 float degree;
	 QPainter painter;
	 float computeInfo(const Object & obj);
	 void printInfo();
	 void ShowInfo();
};

#endif
