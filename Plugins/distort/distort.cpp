// GLarena, a plugin based platform to teach OpenGL programming
// © Copyright 2012-2018, ViRVIG Research Group, UPC, https://www.virvig.eu
// 
// This file is part of GLarena
//
// GLarena is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

#include "distort.h"
#include <QCoreApplication>

const int IMAGE_WIDTH = 512;
const int IMAGE_HEIGHT = IMAGE_WIDTH;

void Distort::onPluginLoad()
{
	GLWidget & g = * glwidget();
	g.makeCurrent();

	vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
	vs->compileSourceFile("distort.vert");

	fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
	fs->compileSourceFile("distort.frag");

	program = new QOpenGLShaderProgram(this);
	program->addShader(vs);
	program->addShader(fs);
	program->link();

	g.glActiveTexture(GL_TEXTURE0);
	g.glGenTextures(1, &textureId);
	g.glBindTexture(GL_TEXTURE_2D, textureId);
	g.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
	g.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
	g.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR );
	g.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
	g.glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, IMAGE_WIDTH, IMAGE_HEIGHT, 0, GL_RGB, GL_FLOAT, NULL);
	g.glBindTexture(GL_TEXTURE_2D, 0);
	g.resize(IMAGE_WIDTH,IMAGE_HEIGHT);
	
	elapsedTimer.start();
}

void drawRect(GLWidget & g)
{
	static bool created = false;
	static GLuint VAO_rect;

	if (! created)
	{
		created = true;
		g.glGenVertexArrays(1, &VAO_rect);
		g.glBindVertexArray(VAO_rect);
		float coords[] = {
			-1, -1,  0,
			 1, -1,  0,
			-1,  1,  0,
			 1,  1,  0
		};
		GLuint VBO_coords;
		g.glGenBuffers(1, &VBO_coords);
		g.glBindBuffer(GL_ARRAY_BUFFER, VBO_coords);
		g.glBufferData(GL_ARRAY_BUFFER, sizeof(coords), coords, GL_STATIC_DRAW);
		g.glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, 0);
		g.glEnableVertexAttribArray(0);
		g.glBindVertexArray(0);
	}

	g.glBindVertexArray (VAO_rect);
	g.glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
	g.glBindVertexArray(0);
}

bool Distort::paintGL()
{
	GLWidget & g = * glwidget();
	
	// Draw scene.
	g.glClearColor(0,0,0,0);
	g.glClear(GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT);
	if (drawPlugin()) drawPlugin()->drawScene();

	// Get texture.
	g.glBindTexture(GL_TEXTURE_2D, textureId);
	g.glCopyTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, 0, 0, IMAGE_WIDTH, IMAGE_HEIGHT);
	g.glGenerateMipmap(GL_TEXTURE_2D);

	// Draw rectangle using texture.
	g.glClear(GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT);
	program->bind();
	program->setUniformValue("colorMap", 0);
	program->setUniformValue("SIZE", float(IMAGE_WIDTH));  
	program->setUniformValue("time", float(elapsedTimer.elapsed() / 1000.0f));
	program->setUniformValue("modelViewProjectionMatrix", QMatrix4x4());  
	drawRect(g);

	g.defaultProgram()->bind();
	g.glBindTexture(GL_TEXTURE_2D, 0);
	return true;
}