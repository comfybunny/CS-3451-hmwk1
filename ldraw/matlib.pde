// http://www.cc.gatech.edu/~turk/cs3451_2014_spring/hw1/hw1.html
// CS 3451 Spring 2013 Homework 1 Stub
// Dummy routines for matrix transformations.
// These are for you to write!

ArrayList<ArrayList<gtMatrix>> matrixStack;
gtMatrix idMatrix = new gtMatrix();



ArrayList<gtVertex> lineHolder;

boolean isOrth = false;
boolean isPerspective = false;

float left, right, bottom, top, ffar, fovy, nnear;

private class gtMatrix {
  public float[][] m;
  gtMatrix() {
    m = new float[4][4];
  }
  // take toMult*m
  float[][] multiply(gtMatrix toMult){
    float[][] answer = new float[4][4];
    answer[0][0] = toMult.m[0][0]*m[0][0] + toMult.m[0][1]*m[1][0] + toMult.m[0][2]*m[2][0] + toMult.m[0][3]*m[3][0];
    answer[0][1] = toMult.m[0][0]*m[0][1] + toMult.m[0][1]*m[1][1] + toMult.m[0][2]*m[2][1] + toMult.m[0][3]*m[3][1];
    answer[0][2] = toMult.m[0][0]*m[0][2] + toMult.m[0][1]*m[1][2] + toMult.m[0][2]*m[2][2] + toMult.m[0][3]*m[3][2];
    answer[0][3] = toMult.m[0][0]*m[0][3] + toMult.m[0][1]*m[1][3] + toMult.m[0][2]*m[2][3] + toMult.m[0][3]*m[3][3];
    answer[1][0] = toMult.m[1][0]*m[0][0] + toMult.m[1][1]*m[1][0] + toMult.m[1][2]*m[2][0] + toMult.m[1][3]*m[3][0];
    answer[1][1] = toMult.m[1][0]*m[0][1] + toMult.m[1][1]*m[1][1] + toMult.m[1][2]*m[2][1] + toMult.m[1][3]*m[3][1];
    answer[1][2] = toMult.m[1][0]*m[0][2] + toMult.m[1][1]*m[1][2] + toMult.m[1][2]*m[2][2] + toMult.m[1][3]*m[3][2];
    answer[1][3] = toMult.m[1][0]*m[0][3] + toMult.m[1][1]*m[1][3] + toMult.m[1][2]*m[2][3] + toMult.m[1][3]*m[3][3];
    answer[2][0] = toMult.m[2][0]*m[0][0] + toMult.m[2][1]*m[1][0] + toMult.m[2][2]*m[2][0] + toMult.m[2][3]*m[3][0];
    answer[2][1] = toMult.m[2][0]*m[0][1] + toMult.m[2][1]*m[1][1] + toMult.m[2][2]*m[2][1] + toMult.m[2][3]*m[3][1];
    answer[2][2] = toMult.m[2][0]*m[0][2] + toMult.m[2][1]*m[1][2] + toMult.m[2][2]*m[2][2] + toMult.m[2][3]*m[3][2];
    answer[2][3] = toMult.m[2][0]*m[0][3] + toMult.m[2][1]*m[1][3] + toMult.m[2][2]*m[2][3] + toMult.m[2][3]*m[3][3];
    answer[3][0] = toMult.m[3][0]*m[0][0] + toMult.m[3][1]*m[1][0] + toMult.m[3][2]*m[2][0] + toMult.m[3][3]*m[3][0];
    answer[3][1] = toMult.m[3][0]*m[0][1] + toMult.m[3][1]*m[1][1] + toMult.m[3][2]*m[2][1] + toMult.m[3][3]*m[3][1];
    answer[3][2] = toMult.m[3][0]*m[0][2] + toMult.m[3][1]*m[1][2] + toMult.m[3][2]*m[2][2] + toMult.m[3][3]*m[3][2];
    answer[3][3] = toMult.m[3][0]*m[0][3] + toMult.m[3][1]*m[1][3] + toMult.m[3][2]*m[2][3] + toMult.m[3][3]*m[3][3];
    return answer;
  }
}

private class gtVertex {
  public float[] v;
  gtVertex() {
    v = new float[4];
  }
}


void gtInitialize() {
  matrixStack = new ArrayList<ArrayList<gtMatrix>>();
  idMatrix.m[0][0] = 1;
  idMatrix.m[1][1] = 1;
  idMatrix.m[2][2] = 1;
  idMatrix.m[3][3] = 1;
  ArrayList<gtMatrix> initMatrix = new ArrayList<gtMatrix>();
  initMatrix.add(idMatrix);
  matrixStack.add(initMatrix);
}

void gtPushMatrix() {
  int stackPointer = matrixStack.size()-1;
  ArrayList<gtMatrix> tempMatrix = new ArrayList<gtMatrix>();
  ArrayList<gtMatrix> matrixHolder = matrixStack.get(stackPointer);
  for(int i=0; i<matrixHolder.size(); i++){
    gtMatrix temp = new gtMatrix();
    for(int x=0; x<4; x++){
      for(int y=0; y<4; y++){
        temp.m[x][y] = matrixHolder.get(i).m[x][y];
      }
    }
    tempMatrix.add(temp);
  }
  matrixStack.add(tempMatrix);
}

void gtPopMatrix() {
   // if only one thing on stack, then return an error
   if(matrixStack.size()==1){
     print("ah staph! ERROR! pop attempted when only one matrix on stack. ABORT MISSION.");
   }
   else{
     matrixStack.remove(matrixStack.size()-1);
   }
}

void gtTranslate(float tx, float ty, float tz) { 
  gtMatrix translate = new gtMatrix();
  
  translate.m[0][0] = 1;
  translate.m[1][1] = 1;
  translate.m[2][2] = 1;
  translate.m[3][3] = 1;
  
  translate.m[0][3] = tx;
  translate.m[1][3] = ty;
  translate.m[2][3] = tz;
  
  matrixStack.get(matrixStack.size()-1).add(translate);
}

void gtScale(float sx, float sy, float sz) {
  gtMatrix scale = new gtMatrix();
  
  scale.m[0][0] = sx;
  scale.m[1][1] = sy;
  scale.m[2][2] = sz;
  scale.m[3][3] = 1;
  
  matrixStack.get(matrixStack.size()-1).add(scale);

}

float[] normed(float[] vector){
  float mag = sqrt(vector[0]*vector[0] + vector[1]*vector[1] + vector[2]*vector[2]);
  for(int i=0; i<3; i++){
    vector[i] = vector[i]/mag;
  }
  return vector;
}

// axb = <a1b2-a2b1, a2b0-a0b2, a0b1-a1b0>


void gtRotate(float angle, float ax, float ay, float az) { 
  gtMatrix rotate1 = new gtMatrix();
  float[] aVector = new float[3];
  aVector[0] = ax;
  aVector[1] = ay;
  aVector[2] = az;
  aVector = normed(aVector);
  //println("aVector  x: " + aVector[0] + "  y: " + aVector[1] + "  z: " + aVector[2]);
  rotate1.m[0][0] = aVector[0];
  rotate1.m[0][1] = aVector[1];
  rotate1.m[0][2] = aVector[2];
  float[] normVector = new float[3];
  if(ax==0){
    // normal vector = (1,0,0) to guarantee not parallel to A
    normVector[0] = 1;
    normVector[1] = 0;
    normVector[2] = 0;
  }
  else{
    // normal vector = N(0,1,0)
    normVector[0] = 0;
    normVector[1] = 1;
    normVector[2] = 0;
  }
  
  //println("normVector  x: " + normVector[0] + "  y: " + normVector[1] + "  z: " + normVector[2]);

  
  float[] bVector = new float[3];
  bVector[0] = aVector[1]*normVector[2] - aVector[2]*normVector[1];
  bVector[1] = aVector[2]*normVector[0] - aVector[0]*normVector[2];
  bVector[2] = aVector[0]*normVector[1] - aVector[1]*normVector[0];
  bVector = normed(bVector);
  
  //println("b Vector  x: " + bVector[0] + "  y: " + bVector[1] + "  z: " + bVector[2]);

  rotate1.m[1][0] = bVector[0];
  rotate1.m[1][1] = bVector[1];
  rotate1.m[1][2] = bVector[2];  
  
  float[] cVector = new float[3];
  cVector[0] = aVector[1]*bVector[2] - aVector[2]*bVector[1];
  cVector[1] = aVector[2]*bVector[0] - aVector[0]*bVector[2];
  cVector[2] = aVector[0]*bVector[1] - aVector[1]*bVector[0];
  cVector = normed(cVector);
  //println("c Vector  x: " + cVector[0] + "  y: " + cVector[1] + "  z: " + cVector[2]);

  rotate1.m[2][0] = cVector[0];
  rotate1.m[2][1] = cVector[1];
  rotate1.m[2][2] = cVector[2];
  
  rotate1.m[3][3] = 1;
  //println("rotate1 matrix");
  for(int i=0; i<4; i++){
    for(int j=0; j <4; j++){
      //print(rotate1.m[i][j] + "\t");
    }
    //println();
  }
  
  gtMatrix rotate2 = new gtMatrix();
  rotate2.m[0][0] = 1;
  rotate2.m[3][3] = 1;
  
  float radians = angle*(PI/180.0);
  
  rotate2.m[1][1] = cos(radians);
  rotate2.m[1][2] = -1*sin(radians);
  rotate2.m[2][1] = sin(radians);
  rotate2.m[2][2] = cos(radians);
  
  gtMatrix rotate3 = new gtMatrix();
  for(int i = 0; i<4; i++){
    for(int j = 0; j<4; j++){
      rotate3.m[j][i] = rotate1.m[i][j];
    }
  }
    //println("rotate2 incoming    angle: " + angle);
    for(int i=0; i<4; i++){
    for(int j=0; j <4; j++){
      //print(rotate2.m[i][j] + "\t");
    }
    //println();
  }
  
    //println("rotate3 incoming");  
    for(int i=0; i<4; i++){
    for(int j=0; j <4; j++){
      //print(rotate3.m[i][j] + "\t");
    }
    //println();
  }
  
  gtMatrix tempRot = new gtMatrix();
  tempRot.m = rotate2.multiply(rotate3);

    // println("r3*r2 incoming");
    for(int i=0; i<4; i++){
    for(int j=0; j <4; j++){
      // print(tempRot.m[i][j] + "\t");
    }
    // println();
  }  
  
  gtMatrix actualRotate = new gtMatrix();
  actualRotate.m = rotate1.multiply(tempRot);
  
  matrixStack.get(matrixStack.size()-1).add(actualRotate);
    
    //println("actual rotate incoming");  
    for(int i=0; i<4; i++){
    for(int j=0; j <4; j++){
      //print(actualRotate.m[i][j] + "\t");
    }
    //println();
    }
}

void gtPerspective(float fovy, float nnear, float ffar) { 
  this.fovy = fovy;
  this.nnear = -1*nnear;
  this.ffar = -1*ffar;
  isOrth = false;
  isPerspective = true;

}

void gtOrtho(float left, float right, float bottom, float top, float nnear, float ffar) {
  this.left = left;
  this.right = right;
  this.bottom = bottom;
  this.top = top;
  this.nnear = -1*nnear;
  this.ffar = -1*ffar;
  isOrth = true;
  isPerspective = false;
}

void gtBeginShape(int type) { 
  lineHolder = new ArrayList<gtVertex>();
}

void gtEndShape() { 
  if(lineHolder.size()%2!=0){
    print("HALP WRONG NUMBER OF POINTS");
  }
}

void gtVertex(float x, float y, float z) {
  
  gtVertex tempLine = new gtVertex();
  tempLine.v[0] = x;
  tempLine.v[1] = y;
  tempLine.v[2] = z;
  tempLine.v[3] = 1;
 
 // current transformation matrix
  ArrayList<gtMatrix> ctm = matrixStack.get(matrixStack.size()-1);
  float floatX;
  float floatY;
  float floatZ;
  //println("Size of Stack: " + matrixStack.size());
  //println("Number of Matrices in Stack: " + ctm.size());
  //println("ORIGINAL POINTS: " + "  X: " + tempLine.v[0] + "  Y: " + tempLine.v[1] + "  Z: " + tempLine.v[2]);
  for(int i = ctm.size()-1; i>=0; i--){
    
    gtMatrix tempT = ctm.get(i);
    
    //println("matrix to be multiply by vertex");
    //for(int iii=0; iii<4; iii++){
    //for(int jjj=0; jjj <4; jjj++){
      //print(tempT.m[iii][jjj] + "\t");
    //}
      //println();
  //}  
  
    floatX = tempT.m[0][0]*tempLine.v[0] + tempT.m[0][1]*tempLine.v[1] + tempT.m[0][2]*tempLine.v[2] + tempT.m[0][3];
    //println("~~~~~row2 col1: "  + tempT.m[1][0] + "  X-val:" + tempLine.v[0]);
    floatY = tempT.m[1][0]*tempLine.v[0] + tempT.m[1][1]*tempLine.v[1] + tempT.m[1][2]*tempLine.v[2] + tempT.m[1][3];
    floatZ = tempT.m[2][0]*tempLine.v[0] + tempT.m[2][1]*tempLine.v[1] + tempT.m[2][2]*tempLine.v[2] + tempT.m[2][3];
    //println("ITERATION: " + i + "  X: " + tempLine.v[0] + "  Y: " + tempLine.v[1] + "  Z: " + tempLine.v[2]);
    tempLine.v[0] = floatX;
    tempLine.v[1] = floatY;
    tempLine.v[2] = floatZ;
  }
  
  

  //float left, right, bottom, top, nnear, ffar;

  if(isOrth&&!isPerspective){
      tempLine.v[0] = (tempLine.v[0]-left)/(right-left)*width;
      tempLine.v[1] = (tempLine.v[1]-bottom)/(top-bottom)*height;
      // println("X: " + tempLine.v[0] + "  Y: " + tempLine.v[1]);
  }
  
  else if(isPerspective&&!isOrth){
//(float , float nnear, float ffar)
    float k = nnear*tan(fovy/180.0*PI/2.0);
    float yPrime = nnear*tempLine.v[1]/Math.abs(tempLine.v[2]);
    //yprime is left right left bottom but need to map into screen
    float xPrime = nnear*tempLine.v[0]/Math.abs(tempLine.v[2]);
    tempLine.v[0] = (xPrime+k)*height/2.0/k;
    tempLine.v[1] = (yPrime+k)*height/2.0/k;
  }
    //println("SCREEN MAPPING: " + "  X: " + tempLine.v[0] + "  Y: " + tempLine.v[1]);
  lineHolder.add(tempLine);
  
  float x0;
  float y0;
  float x1;
  float y1;
  float z0;
  float z1;

// model view projection/prospective
  
  if(lineHolder.size()%2==0 && (lineHolder.size()!=0)){
    // draw a line
    x0 = lineHolder.get(lineHolder.size()-2).v[0];
    y0 = lineHolder.get(lineHolder.size()-2).v[1];
    x1 = lineHolder.get(lineHolder.size()-1).v[0];
    y1 = lineHolder.get(lineHolder.size()-1).v[1];
    z0 = lineHolder.get(lineHolder.size()-2).v[2];
    z1 = lineHolder.get(lineHolder.size()-1).v[2];  
    xyz p0 = new xyz(x0, y0, z0);
    xyz p1 = new xyz(x1, y1, z1);
    
    if(near_far_clip(nnear,ffar,p0,p1)>0){
      draw_line(p0.x,p0.y,p1.x,p1.y);    
    }
  }

  //println("x0: " + x0 + "  x1: " + x1 + "  y0: " + y0 + "  y1: " + y1);
  //println(lineHolder.size());
}

