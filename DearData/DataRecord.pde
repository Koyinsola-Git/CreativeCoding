public class DataRecord{
  private Date date;
  private Status status;
  private int numberOfTrains;
  
  public DataRecord(Date date,Status status, int trains){
    this.date = date;
    this.status = status;
    this.numberOfTrains = trains;
  }
  
  public Date getDate(){
    return date;
  }
  public Status getStatus(){
    return status;
  }
  public int getTrains(){
    return numberOfTrains;
  }
}
