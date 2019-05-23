public class Buyer implements Actor {
  
    private double extreme;
    private double price;
    private boolean bHasItem;
    
    public Buyer(double e, double p){
      this.extreme = e;
      this.price = p;
      this.bHasItem = false;
  
    }  
  
   public double getExtreme(){
      return this.extreme; 
     
   }
   
   public double getPrice(){
      return this.price; 
   }
  
   public boolean canNegotiateWith(Actor a){
       if (a.getExtreme() > this.getExtreme() || this.bHasItem == true || a.getItem() == false)
         return false;
       return true;  
   }
   
   public void setPrice(double p){
      this.price = p; 
   }
   
   public boolean giveItem(){
       this.bHasItem = true;
       return this.bHasItem;
   }
   public boolean takeItem(){
       this.bHasItem = false;
       return this.bHasItem;
   }
  public boolean getItem(){
     return this.bHasItem; 
  }
   
}