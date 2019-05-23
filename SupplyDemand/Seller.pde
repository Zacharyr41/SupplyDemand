public class Seller implements Actor {
    private double extreme;
    private double price;
    private boolean bHasItem;
    
    public Seller(double e, double p){
      this.extreme = e;
      this.price = p;
      this.bHasItem = true;
  
    }  
  
   public double getExtreme(){
      return this.extreme; 
     
   }
   
   public double getPrice(){
      return this.price; 
   }
   
   public boolean canNegotiateWith(Buyer b){
       if (b.getExtreme() < this.extreme|| this.bHasItem == false || b.getItem() == true)
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