#ifndef _OBJECTSELECTION_H
#define _OBJECTSELECTION_H

#include "plugin.h" 

class ObjectSelection: public QObject, public Plugin
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
	 void mouseReleaseEvent(QMouseEvent *);
  private:
	 QOpenGLShaderProgram * boxShaderProgram;
	 QOpenGLShader * boxVertexShader, * boxFragmentShader;
	 QOpenGLShaderProgram * selectionShaderProgram;
	 QOpenGLShader * selectionVertexShader, * selectionFragmentShader;
	 GLuint boxId;
	 void createBox(GLWidget &);
	 void linkBoxShaders();
	 void linkSelectionShaders();
	 void drawBox(GLWidget &, const Box &);


};

#endif
