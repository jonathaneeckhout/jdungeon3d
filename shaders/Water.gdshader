shader_type spatial;
uniform sampler2D DEPTH_TEXTURE : hint_depth_texture, filter_linear_mipmap;
uniform vec4 out_col : source_color = vec4(1.0,1.0,1.0,1.0);
uniform float amount : hint_range(0.2,1.5) = 0.8;
uniform float beer_factor = 0.2;
uniform float metallic = 0.7;
uniform float roughness = 0.3;
uniform float specular = 0.5;

float gen_offset(float x, float z, float val1, float val2, float time){
	float spd=1.0;
	
	float radX = ((mod(x+z*x*val1,amount)/amount)+(time*spd)*mod(x*0.8+z,1.5))*2.0*3.14;
	float radZ = ((mod(val2*(z*x+x*z),amount)/amount)+(time*spd)*2.0*mod(x,2.0))*2.0*3.14;
	
	return amount*0.5*(sin(radZ)+cos(radX));
}

vec3 apply_dist(vec3 vertex, float time){
	float xd = gen_offset(vertex.x,vertex.z,0.2,0.1,time);
	float yd = gen_offset(vertex.x,vertex.z,0.1,0.3,time);
	float zd = gen_offset(vertex.x,vertex.z,0.15,0.2,time);
	
	return vertex+vec3(xd,yd,zd);
}

void vertex(){
	VERTEX = apply_dist(VERTEX, TIME*0.1);
}

void fragment(){
	ALBEDO = out_col.xyz;
	NORMAL = normalize(cross( dFdx(VERTEX), dFdy(VERTEX) ));
	METALLIC = metallic;
	SPECULAR = specular;
	ROUGHNESS = roughness;
	
	float depth = texture(DEPTH_TEXTURE,SCREEN_UV).r;
	
	
	depth = depth*2.0-1.0;
	depth = PROJECTION_MATRIX[3][2]/(depth+PROJECTION_MATRIX[2][2]);
	depth = depth+VERTEX.z;
	
	depth = exp(-depth*beer_factor);
	ALPHA = clamp(1.0-depth,0.0,1.0);
}