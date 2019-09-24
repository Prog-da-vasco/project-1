import java.util.Scanner;

class Main
{
	public int distance[];
	public int numb_vert;
	static public final int MAX_VALUE = 999;

	public Main(int numb_vert)
	{
		this.numb_vert=numb_vert;
		distance = new int[this.numb_vert+1];
	}

	public void bellman_does(int source,int adj_matrix[][])
	{
	   
		for(int node=1;node<=numb_vert;node++)
			distance[node] = MAX_VALUE;
		distance[source]=0;

		for(int node=1;node<=numb_vert-1;node++)
		{
			for(int src_node=1;src_node<=numb_vert;src_node++)
			{
				for(int dest_node=1;dest_node<=numb_vert;dest_node++)
				{
					if(adj_matrix[src_node][dest_node]!=MAX_VALUE)
						if(distance[dest_node] > distance[src_node]+adj_matrix[src_node][dest_node])
							distance[dest_node] = distance[src_node] + adj_matrix[src_node][dest_node];
				}
			}
		}

		for(int src_node=1;src_node<=numb_vert;src_node++)
		{
			for(int dest_node=1;dest_node<=numb_vert;dest_node++)
			{
				if(adj_matrix[src_node][dest_node]!=MAX_VALUE)
					if(distance[dest_node] > distance[src_node]+adj_matrix[src_node][dest_node])
						System.out.println("Graph contains negative edge cycle");
			}
		}	
			
		System.out.println("Routing table for router "+source+" is");
		System.out.println("Destination		distance\t");

		for(int vertex=1;vertex<=numb_vert;vertex++)
			System.out.println(vertex+"\t\t\t"+distance[vertex]);
 	}

 	public static void main(String args[])
 	{
 		int numb_vert=0;
 		int source;
 		Scanner in = new Scanner(System.in);

 		System.out.println("Enter the number of vertices");
 		numb_vert = in.nextInt();

 		int adj_matrix[][] = new int[numb_vert+1][numb_vert+1];

 		System.out.println("Enter the adjacency matrix");
 		for(int src_node=1;src_node<=numb_vert;src_node++)
 			for(int dest_node=1;dest_node<=numb_vert;dest_node++)
 			{
 				adj_matrix[src_node][dest_node] = in.nextInt();
 				if(src_node==dest_node)
 				{
 					adj_matrix[src_node][dest_node] = 0;
 					continue;
 				}
 				if(adj_matrix[src_node][dest_node]==0)
 					adj_matrix[src_node][dest_node] = MAX_VALUE;
 			}
 		for(int i=1;i<=numb_vert;i++)
 		{
 		   
 			Main ford = new Main(numb_vert);
 			ford.bellman_does(i,adj_matrix);
 		}
 	}
}
