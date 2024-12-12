public class GraphNode{
  private final DataRecord data;
  public int hoverFrameCount;
  
  public GraphNode(DataRecord data){
     this.data = data;
     this.hoverFrameCount = 0;
  }
  
  public DataRecord getData(){
    return this.data;
  }

}
