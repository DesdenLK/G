#ifndef _DEPTHNORMAL2_H
#define _DEPTHNORMAL2_H

#include "plugin.h" 

class Depthnormal2: public QObject, public Plugin
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
	QOpenGLShaderProgram * depthProgram;
	QOpenGLShader * dephtVertexShader, * depthFragmentShader;
	QOpenGLShaderProgram * normalShaderProgram;
	QOpenGLShader * normalVertexShader, * normalFragmentShader;
	void linkDepthShaders();
	void linkNormalShaders();
};

#endif
