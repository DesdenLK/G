#ifndef _ANIMATE_VERTICES_REPAS_H
#define _ANIMATE_VERTICES_REPAS_H

#include "plugin.h"
#include <QElapsedTimer> 

class Animate_Vertices_REPAS: public QObject, public Plugin
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
	QElapsedTimer elapsedTimer;
	QOpenGLShaderProgram *program;
	QOpenGLShader *fs, * vs;
};

#endif
