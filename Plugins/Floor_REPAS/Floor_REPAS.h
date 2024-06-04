#ifndef _FLOOR_REPAS_H
#define _FLOOR_REPAS_H

#include "plugin.h" 

class Floor_REPAS: public QObject, public Plugin
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
	 float lambda;
	 float computeLambda(const Object & object);
	 QOpenGLShaderProgram * program;
	 QOpenGLShader * vs, * fs;

	 void linkshaders();
};

#endif
