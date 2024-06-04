#ifndef _DEPHTNORMAL_H
#define _DEPHTNORMAL_H

#include "plugin.h" 

class Dephtnormal: public QObject, public Plugin
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
