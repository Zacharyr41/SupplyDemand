  ArrayList<Buyer> buyers = new ArrayList<Buyer>();
  ArrayList<Seller> sellers = new ArrayList<Seller>();
  ArrayList<Buyer> buyerHolder = new ArrayList<Buyer>();
  ArrayList<Seller> sellerHolder = new ArrayList<Seller>();
  
  int numBuyers = 25;
  int numSellers = 5;
  int numDays = 20;
  
void setup(){
  for (int i = 0; i < numBuyers; i++){
      double r = 20 + Math.random()*30;
      buyers.add(new Buyer(r, r/2));
  }
  for (int i = 0; i < numSellers; i++){
      double r = 20 + Math.random()*30;
      sellers.add(new Seller(r, r/2));
  }
  
  //Each day
  for (int i = 0; i < numDays; i++){
     //Randomly Assign buyers to sellers
     
  }
}

void draw(){
  
}

double findPrice(Buyer b, Seller s){
      double currentPrice = b.getPrice();
      double otherPrice = s.getPrice();
      if (!b.canNegotiateWith(s) || Math.abs(currentPrice - otherPrice) > 3.0 ){
         return -1.0; 
      }
      while (Math.abs(currentPrice - otherPrice) > 0.5){
         double difference = currentPrice - otherPrice;     
         if (difference > 0){
            currentPrice -= Math.random()*0.5*difference;
            otherPrice += Math.random()*0.5*difference;
         }
         else if (difference < 0){
            currentPrice += Math.random()*0.5*difference;
            otherPrice -= Math.random()*0.5*difference;
         }
      }
      int random = (int)(2*Math.random());
      if (random == 0){
        return currentPrice;
      }
      else{
        return otherPrice; 
      }
  }
  

  boolean makeSale(Buyer b, Seller s){
     double price = findPrice(b, s);
     if (price == -1.0){
        return false; 
     }
     else {
       b.giveItem();
       s.takeItem();
       if (s.getPrice() <= price){
          s.setPrice(s.getPrice() + Math.random()); 
       }
       else if ( s.getPrice() > price){
          s.setPrice(s.getPrice() - Math.random());
       }
       
       if (b.getPrice() >= price){
          b.setPrice(b.getPrice() - Math.random()); 
       }
       else if ( b.getPrice() < price){
          b.setPrice(b.getPrice() + Math.random()); 
       }
       return true;
     }
    
  }