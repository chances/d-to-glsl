
module dglsl.gspl;

import gfm.math;
import std.string;

import opengl;
import dglsl.gl;
import dglsl.type;

/// Section: `glUniform` overloads

void glUniform(GLint location, GLfloat v0) {
	glUniform1f(location, v0);
}

void glUniform(GLint location, GLfloat v0, GLfloat v1) {
	glUniform2f(location, v0, v1);
}

void glUniform(GLint location, GLfloat v0, GLfloat v1, GLfloat v2) {
	glUniform3f(location, v0, v1, v2);
}

void glUniform(GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3) {
	glUniform4f(location, v0, v1, v2, v3);
}

void glUniform(GLint location, GLint v0) {
	glUniform1i(location, v0);
}

void glUniform(GLint location, GLint v0, GLint v1) {
	glUniform2i(location, v0, v1);
}

void glUniform(GLint location, GLint v0, GLint v1, GLint v2) {
	glUniform3i(location, v0, v1, v2);
}

void glUniform(GLint location, GLint v0, GLint v1, GLint v2, GLint v3) {
	glUniform4i(location, v0, v1, v2, v3);
}

void glUniform1v(GLint location, GLsizei count, const GLfloat[] value) {
	glUniform1fv(location, count, value.ptr);
}

void glUniform2v(GLint location, GLsizei count, const GLfloat[] value) {
	glUniform2fv(location, count, value.ptr);
}

void glUniform3v(GLint location, GLsizei count, const GLfloat[] value) {
	glUniform3fv(location, count, value.ptr);
}

void glUniform4v(GLint location, GLsizei count, const GLfloat[] value) {
	glUniform4fv(location, count, value.ptr);
}

void glUniform1v(GLint location, GLsizei count, const GLint[] value) {
	glUniform1iv(location, count, value.ptr);
}

void glUniform2v(GLint location, GLsizei count, const GLint[] value) {
	glUniform2iv(location, count, value.ptr);
}

void glUniform3v(GLint location, GLsizei count, const GLint[] value) {
	glUniform3iv(location, count, value.ptr);
}

void glUniform4v(GLint location, GLsizei count, const GLint[] value) {
	glUniform4iv(location, count, value.ptr);
}

void glUniformMatrix(GLint location, GLboolean transpose, const GLfloat[4] value) {
	glUniformMatrix2fv(location, 1, transpose, value.ptr);
}

void glUniformMatrix(GLint location, GLboolean transpose, const GLfloat[9] value) {
	glUniformMatrix3fv(location, 1, transpose, value.ptr);
}

void glUniformMatrix(GLint location, GLboolean transpose, const GLfloat[16] value) {
	glUniformMatrix4fv(location, 1, transpose, value.ptr);
}

void glUniform(int dim)(GLint location, Vector!(float, dim) v) {
	mixin(`glUniform%dfv(location, 1, v.value_ptr);`.format(dim));
}

void glUniform(int dim)(GLint location, Matrix!(float, dim, dim) m, GLboolean transpose = false) {
	mixin(`glUniformMatrix%dfv(location, 1, transpose, m.value_ptr);`.format(dim));
}

void glUniform(int column, int row)(GLint location, Matrix!(float, column, row) m, GLboolean transpose = false) if (column != row) {
	import std.string;
	mixin(`glUniformMatrix%dx%dfv(location, 1, transpose, m.value_ptr);`.format(column, row));
}

// glGetError
void glCheckError(string file = __FILE__, int line = __LINE__) {
	debug final switch (glGetError()) {
		case ErrorCode.noError:
			break;
		case ErrorCode.invalidEnum:
			throw new Exception("Invalid enum error: An unacceptable value is specified for an enumerated argument.", file, line);
			break;
		case ErrorCode.invalidValue:
			throw new Exception("Invalid value error: A numeric argument is out of range.", file, line);
			break;
		case ErrorCode.invalidOperation:
			throw new Exception("Invalid operation error: The specified operation is not allowed in the current state.", file, line);
			break;
		case ErrorCode.stackOverflow:
			// TODO: Add error description
			throw new Exception("Stack underflow error", file, line);
			break;
		case ErrorCode.stackUnderflow:
			// TODO: Add error description
			throw new Exception("Stack underflow error", file, line);
			break;
		case ErrorCode.invalidFramebufferOperation:
			throw new Exception("Invalid framebuffer operation error: The framebuffer object is not complete.", file, line);
			break;
		case ErrorCode.outOfMemory:
			throw new Exception("Out of memory error: There is not enough memory left to execute the command.", file, line);
			break;
		case ErrorCode.contextLost:
			throw new Exception("Lost context error: The graphics context was lost.", file, line);
			break;
		case ErrorCode.tableTooLarge:
			// TODO: Add error description
			throw new Exception("Table too large error", file, line);
	}
}

// opengl device information
void glShowInfo() {
	import std.stdio;
	import std.conv;
	GLint i;

	writefln("Version: %s", glGetString(GlString.version_).to!string);
	writefln("Vendor: %s", glGetString(GlString.version_).to!string);
	writefln("Renderer: %s", glGetString(GlString.renderer).to!string);
	writefln("GLSL Version: %s", glGetString(GlString.shadingLanguageVersion).to!string);

	glGetIntegerv(GL_MAX_TEXTURE_SIZE, &i);
	writefln("Max texture size (RGBA32): %d * %d", i / 4, i / 4);

	stdout.flush();
}
