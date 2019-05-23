  ArrayList<Buyer> buyers = new ArrayList<Buyer>();
  ArrayList<Seller> sellers = new ArrayList<Seller>();
  
  ArrayList<Buyer> buyerHolder = new ArrayList<Buyer>();
  ArrayList<Seller> sellerHolder = new ArrayList<Seller>();
  ArrayList<TransactionPair> pairs = new ArrayList<TransactionPair>();
  
  int numBuyers = 5;
  int numSellers = 5;
  int numDays = 100;
  int graphWidth = 700;
  float ellipseSize = 20;
  
void setup(){
  
  size(800, 800);
  for (int i = 1; i <= numBuyers; i++){
      double r = 5 + (numBuyers - i);
      buyers.add(new Buyer(r, r/2));
  }
  for (int i = 1; i <= numSellers; i++){
      double r = 5 + (Math.abs(numBuyers - numSellers)) + i;
      sellers.add(new Seller(r, r/2));
  }
  
  /*
    Each day requires certain tasks:
    1) Loop through buyers and sellers and assign them randomly to each other until all rockets are sold or no sales can be made
    2) Use the makeSale function to achieve (1). Remove any buyer that has item or seller who doesn't from holder arraylists.
    3) (1) and (2) have excluded buyers raise prices and excluded sellers lower prices
    4) Replenish Seller stocks and empty buyer stocks. 
  */
  System.out.println("Extreme of index 2 is: " + buyers.get(2).getExtreme());
  for (int day = 0; day < numDays; day++){
    delay(50);
    if (day == 20){
    System.out.println("Index 2, Start of day: " + buyers.get(2).getPrice());
    }
     background(0, 255, 0);
     
     //delay(1);
     
     pushStyle();
     
       pushStyle();
       rectMode(CENTER);
       strokeWeight(3);
       noFill();
       rect(width/2, height/2, graphWidth, graphWidth);
       popStyle();
       
       pushStyle();
       textSize(30);
       fill(0, 0, 0);
       text("Supply and Demand", width/2 -150 , height/2 - (graphWidth/2 - 50) );
       popStyle();
       
     popStyle();
    
     int counter = 0;
     int times = 0;
     //Copy ArrayList of buyers and sellers into their respective holder arrays
     for (Buyer b : buyers){
         buyerHolder.add(b); 
     }
       
     for (Seller s : sellers){
         sellerHolder.add(s); 
     }
       //Third condition: how many times to loop through arraylists until it is determined no transactions can be made.
     if (buyerHolder.size() >= sellerHolder.size()){
        times = sellerHolder.size(); 
     }
     else {
        times = buyerHolder.size(); 
     }
     
     
    //Random assignment
    while ((buyerHolder.size() > 0 && sellerHolder.size() > 0) && counter <= times){
      //System.out.println("hi");
       if (buyerHolder.size() >= sellerHolder.size()){
          for (int i = sellerHolder.size() - 1; i >= 0; i-- ){
             int buyerIndex = (int)(Math.random()*buyerHolder.size());
             int sellerIndex = (int)(Math.random()*sellerHolder.size());
             
             Buyer randomBuyer = buyerHolder.get(buyerIndex);
             Seller randomSeller = sellerHolder.get(sellerIndex);
             
             pairs.add(new TransactionPair(randomBuyer, randomSeller));
             
             sellerHolder.remove(sellerIndex);
             buyerHolder.remove(buyerIndex);
             
          } 
          for (int i = pairs.size() - 1; i >= 0; i--){
             //System.out.println("lol");
             Buyer BuyerInPair = pairs.get(i).getBuyer();
             Seller SellerInPair = pairs.get(i).getSeller();
             
             boolean itemWasSold = makeSale(BuyerInPair, SellerInPair);
             if (itemWasSold){
                pairs.remove(i);
                //System.out.println("sell pairs");
             }
             
          }
          
          /*for (int i = 0; i < pairs.size(); i++){
             System.out.println(pairs.get(i).getBuyer().getPrice()); 
          } */
          
          //System.out.println("more buyers");
          //Clearing pairs and repopulating buyer and seller arrays
          for (int i = pairs.size() - 1; i >= 0; i--){
              TransactionPair tp = pairs.get(i);
              pairs.remove(tp);
              buyerHolder.add(tp.getBuyer());
              sellerHolder.add(tp.getSeller());
          }
          
          counter++;
          //Process will now begin again
       }
       else if (buyerHolder.size() < sellerHolder.size()) {
          for (int i = buyerHolder.size() - 1; i >= 0; i--){
             int buyerIndex = (int)(Math.random()*buyerHolder.size());
             int sellerIndex = (int)(Math.random()*sellerHolder.size());
             
             Buyer randomBuyer = buyerHolder.get(buyerIndex);
             Seller randomSeller = sellerHolder.get(sellerIndex);
             
             pairs.add(new TransactionPair(randomBuyer, randomSeller));
             
             sellerHolder.remove(sellerIndex);
             buyerHolder.remove(buyerIndex);   
          }
          for (int i = pairs.size() - 1; i >= 0; i--){
             Buyer BuyerInPair = pairs.get(i).getBuyer();
             Seller SellerInPair = pairs.get(i).getSeller();
             boolean itemWasSold = makeSale(BuyerInPair, SellerInPair);
             if (itemWasSold){
                pairs.remove(i); 
                
             }
          }
          
          for (int i = pairs.size() - 1; i >= 0; i--){
              TransactionPair tp = pairs.get(i);
              pairs.remove(tp);
              buyerHolder.add(tp.getBuyer());
              sellerHolder.add(tp.getSeller());
          }
          counter++;
       }
       
       
       
      
    }
    //Last thing to do each day is raise excluded buyers,  lower excluded sellers, replenish sellers, deplete buyers, and clear the holder arrays
    
    //Raise buyers and clear holder arraylist
    if (buyerHolder.size() > 0){
       for (int i = buyerHolder.size() - 1; i >= 0; i--){
         //System.out.println("I was excluded!");
          double randomNum = buyerHolder.get(i).getPrice() + Math.random();
          if (buyerHolder.get(i).getExtreme() > randomNum){
          buyerHolder.get(i).setPrice(randomNum);
          }
          buyerHolder.remove(i);
       }
      
    }
    
    //Lower sellers and clear holder arraylist
    if (sellerHolder.size() > 0){
       for (int i = sellerHolder.size() - 1; i >= 0; i--){
          double randomNum = sellerHolder.get(i).getPrice() - Math.random();
          if (sellerHolder.get(i).getExtreme() < randomNum){
          sellerHolder.get(i).setPrice(randomNum);
          }
          
          sellerHolder.remove(i);
       }
    }
    
    //Replenishing sellers and Depleting buyers
    for (Buyer b : buyers){
       b.takeItem(); 
    }
    
    for (Seller s : sellers){
      s.takeItem(); 
    }
    
    //Graphics for the end of each day
    pushStyle();
      for (int i = 1; i <= numBuyers; i++){
         pushStyle();
         ellipseMode(CENTER);
         fill(255, 165, 0);
         double xCoord = (graphWidth/(2*numBuyers))*(2*i - 1) + (width/2 - graphWidth/2);
         double yCoord = map((float)(buyers.get(i - 1).getExtreme()), 0, 30, (height/2) + graphWidth/2, height/2 - graphWidth/2);
         //ellipse((float)xCoord, (float)yCoord, ellipseSize, ellipseSize);
         double yPrice = map((float)(buyers.get(i - 1).getPrice()), 0, 30, (height/2) + graphWidth/2, height/2 - graphWidth/2);
         stroke(0, 0, 0);
         strokeWeight(5);
         line((float)(xCoord - ellipseSize/2), (float)yPrice, (float)(xCoord + ellipseSize/2), (float)yPrice);
         popStyle();
         
         
         
      }
      for (int j = 1; j <= numSellers; j++){
         pushStyle();
         ellipseMode(CENTER);
         fill(0, 0, 255);
         double xCoord = (graphWidth/(2*numSellers))*(2*j - 1) + (width/2 - graphWidth/2);
         double yCoord = map((float)(sellers.get(j - 1).getExtreme()), 0, 30, (height/2) + graphWidth/2, height/2 - graphWidth/2);
         //ellipse((float)xCoord, (float)yCoord, ellipseSize, ellipseSize);
         double yPrice = map((float)(sellers.get(j - 1).getPrice()), 0, 30, (height/2) + graphWidth/2, height/2 - graphWidth/2);
         stroke(255, 0, 0);
         strokeWeight(5);
         line((float)(xCoord - ellipseSize/2), (float)yPrice, (float)(xCoord + ellipseSize/2), (float)yPrice);
         popStyle(); 
      }
    popStyle();
      
  }
  //System.out.println(buyers.get(2).getPrice());
}

void draw(){
  
}

double findPrice(Buyer b, Seller s){
      double currentPrice = b.getPrice();
      double otherPrice = s.getPrice();
      int increment = 0;
      //boolean rr = Math.abs(currentPrice - otherPrice) > 10.0;
   
      if (!b.canNegotiateWith(s) || Math.abs(currentPrice - otherPrice) > 10.0 ){
         return -1.0;
         
      }
   
       while (Math.abs(currentPrice - otherPrice) > 0.5){
         double difference = currentPrice - otherPrice;
         if (difference > 0){
            currentPrice -= Math.random()*0.5;
            otherPrice += Math.random()*0.5;
         }
         else if (difference < 0){
            currentPrice += Math.random()*0.5;
            otherPrice -= Math.random()*0.5;
         }
         increment++;
      }
      //System.out.println("not here.");
      int random = (int)(2*Math.random());
      if (random == 0){
        return currentPrice;
      }
      else{
        return otherPrice; 
      }
      
      
  }
  
  int n = 0;
  boolean makeSale(Buyer b, Seller s){
    
     double price = findPrice(b, s);
     if (price == -1.0){
        return false; 
     }
     if (price > b.getExtreme()){
        return false; 
     }
     if (price < s.getExtreme()){
        return false; 
     }
     else {
       System.out.println(n);
       n++;
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
  