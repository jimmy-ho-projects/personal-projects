'''
Basic Deck Builder
Builds basic suite of cards; designed to be expandable. Use to make a blackjack game
*10 Aug 2025
- shuffling added 15 Aug 2025
- Jimmy Ho
'''
from random import random as rand
from random import randrange


card_suites = ["Clubs", "Spades", "Hearts", "Diamonds"]
card_numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Joker", "Queen", "King"]
deck_size = len(card_suites) * len(card_numbers)
deck_cards = []
for ii in range(deck_size) :
    deck_cards.append(0) #init empty deck

#build deck 
kk = 0
for ii in card_numbers:
    for jj in card_suites:
        deck_cards[kk] = ii + ' ' + jj
        #print(deck_cards[kk])
        kk = kk+1

#Shuffling Deck
num_iter = randrange(52, 300)
for pp in range(num_iter):
    n1 = randrange(52)
    n2 = randrange(52)
    if n1 != n2: #only swap places if two different cards
        card_swap = deck_cards[n1]
        deck_cards[n1] =  deck_cards[n2]
        deck_cards[n2] = card_swap

#Dealing cards
