public class Date{
   private final int day;
   private final int month;
   private final int year;
   
   public Date(int day,int month,int year){
     this.day = day;
     this.month = month;
     this.year = year;
   }
   
   public int getDay(){
     return this.day;
   }
   public int getMonth(){
     return this.month;
   }
   public int getYear(){
     return this.year;
   }
  
  public String getFormatted(){
    return this.day + "-"+this.month+"-"+this.year;
  }
}
