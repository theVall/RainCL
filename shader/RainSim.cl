#define SPHERE_RADIUS 0.1f
#define DAMPING 0.005f
#define SPRING 1.0f
#define SHEAR 0.12f
#define GRAVITY 0.7f
#define TIME_SCALE 1.0f
#define LOCAL_MEM_SIZE 32

// TODO collide with terrain
/*
float4 collide(
float4 pi,
float4 pj, 
float4 vi, 
float4 vj, 
float distance) 
{
	float4 norm = normalize(pj - pi);
//	float4 relVelo = (vj - vi); //without mass
	float4 relVelo = ((2.0f*vj.w*dot(vj, norm) + dot(vi, norm)*vi.w - vj.w)/(vi.w + vj.w))*norm; 
    float d = dot(norm, relVelo);
    float4 tanVelo = relVelo - d*norm;
	float s = -SPRING*(pi.w + pj.w - distance);
	return (SHEAR*tanVelo + DAMPING*relVelo + s*norm);
}
*/

__kernel void rain_sim(
__global float4* old_points, 
__global float4* new_points,
__global float4* old_velos,
__global float4* new_velos,
uint count,
float dt)
{
    __local float4 sharedMem[LOCAL_MEM_SIZE];
    
    int myId = get_global_id(0);
    float4 myPos = old_points[myId];
	float4 myVelos = old_velos[myId];
    int localId = get_local_id(0);
    int tileSize = get_local_size(0);
    int tileCnt = get_num_groups(0);
    
    // for(int tile = 0; tile < tileCnt; ++tile)
    // {
    	// sharedMem[localId] = old_points[tileSize * tile + localId];
    	// barrier(CLK_LOCAL_MEM_FENCE);
    	// for(int j = 0; j < tileSize; ++j)
    	// {
    		// float4 otherPos = sharedMem[j];
    	// }
    	// barrier(CLK_LOCAL_MEM_FENCE);
    // }
	
	//pseudo random int
	int rand = (myId * 0x5DEECE66DL + 0xBL) & ((1L << 48) - 1);
    
	new_velos[myId].xyz = old_velos[myId].xyz;
	//respawn particle
	if (myPos.y < -2.0f)
	{
		myPos.y = 3.0f + ((float)rand/1000000000.0f);
	}
    new_points[myId].xyz = myPos.xyz - old_velos[myId].xyz * dt;
}