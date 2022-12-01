print("Welcome to Rock, Paper, Scissor Game")
print("Are you ready")
start <- 0
win <- 0
lose <- 0
draw <- 0
while(start == 0){
  print("Take your pick 1.rock 2.paper 3.scissor")
  user_pick <- readLines("stdin", n=1)
  if (user_pick == 1){
    user_choose <- ("user > rock")
  }else if (user_pick == 2){
    user_choose <- ("user > paper")
  }else if (user_pick == 3){
    user_choose <- ("user > scissor")
} 
  bot_pick <- sample(c(1:3),1)
  if (bot_pick == 1){
    bot_choose <- ("bot > rock")
  }else if (bot_pick == 2){
    bot_choose <- ("bot > paper")
  }else if (bot_pick == 3){
    bot_choose <- ("bot > scissor")
  }
# win
if(user_pick == 1 & bot_pick == 3 | 
user_pick == 2 & bot_pick == 1 |
user_pick == 3 & bot_pick == 2) {
print ("Win")
win <- win + 1
}
# lose
if(user_pick == 1 & bot_pick == 2 | 
user_pick == 2 & bot_pick == 3 |
user_pick == 3 & bot_pick == 1) {
print ("Lose")
lose <- lose + 1
}
# draw
if(user_pick == 1 & bot_pick == 1 |
  user_pick == 2 & bot_pick == 2 |
  user_pick == 3 & bot_pick == 3) {
  print ("Draw")
  draw <- draw + 1
}
  else if (user_pick == "q"){
  break
  } else{}
  
  
  if (start == 0){
    print(paste(user_choose))
    print(paste(bot_choose))
  }
}
#result
print("Result")
print(paste("Win =",win,"Lose =",lose,"Draw =",draw))
print("Thanks for playing")
