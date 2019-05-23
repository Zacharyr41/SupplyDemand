public class TransactionPair {
   private Buyer buyer;
   private Seller seller;
   
   public TransactionPair(Buyer b, Seller s){
      this.buyer = b;
      this.seller = s;
   }
   public Buyer getBuyer(){
      return this.buyer; 
   }
   public Seller getSeller(){
      return this.seller; 
   }
   public void setBuyer(Buyer b){
      this.buyer = b; 
   }
   public void setSeller (Seller s){
      this.seller = s; 
   }
}