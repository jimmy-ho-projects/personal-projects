'''
Basic Deck Builder
Builds basic suite of cards; designed to be expandable. Use to make a blackjack game
*10 Aug 2025
- Jimmy Ho
'''

card_suites = ["Clubs", "Spades", "Hearts", "Diamonds"]
card_numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "joker", "queen", "king"]
deck_size = len(card_suites) * len(card_numbers)
deck_cards = []
for ii in range(deck_size) :
    deck_cards.append(0) #init empty deck

#build deck 
kk = 0
for ii in card_numbers:
    for jj in card_suites:
        deck_cards[kk] = jj + ' ' + ii
        print(deck_cards[kk])
        kk = kk+1