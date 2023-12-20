import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="game"
export default class extends Controller {
  static targets = ["dealer", "player", "hit", "pass", "buttonContainer", "nextHand", "hiddenCard", "dealersCards", "playersCards", "notice", "options", "score"];

  connect() {

    console.log("hii it's me again");
    console.log("score: ", this.scoreTarget);
    this.values = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K'];
    this.suits = ['♠', '♥', '♣', '♦'];

    this.allDecks = [];
    this.dealerHand = [];
    this.playerHand = [];

    this.play();
  }

  createDeck() {
    // Implement createDeck logic
    let deck = []
    this.suits.forEach((suit) => {
      this.values.forEach((value) => {
        let card = value + suit;
        deck.push(card);
      })
    })
    return deck;
  }


  shuffleDecks() {
    // Implement shuffleDecks logic
    this.allDecks = Array.from({ length: 4 }, () => this.createDeck()).flat();
    return this.allDecks;
  }

  chooseRandomCard() {
    // Implement chooseRandomCard logic
    let totalCards = this.allDecks.length;
    let randomNumber = Math.floor(Math.random() * totalCards);
    let randomCard = this.allDecks[randomNumber];
    this.allDecks.splice(randomCard, 1);
    return randomCard;
  }

  dealHands() {
    // Implement dealHands logic
    this.dealerHand = [this.chooseRandomCard(), this.chooseRandomCard()];
    this.playerHand = [this.chooseRandomCard(), this.chooseRandomCard()];

    return { dealer: this.dealerHand, player: this.playerHand };
  }

  calcHandValue(hand) {
    // Implement calcHandValue logic
    let value = 0;
    let hasAce = false;
    hand.forEach((card) => {
      // console.log(card);
      let cardValue = card.length === 2 ? card.substring(0, 1) : card.substring(0, 2);
      if (cardValue === 'A') hasAce = true;
      else if (['J', 'Q', 'K'].includes(cardValue)) value += 10;
      else value += Number(cardValue);
    })
    if (hasAce) value + 11 > 21 ? value += 1 : value += 11;
    return value;
  }

  showNotice(text) {
    // Implement showNotice logic
    // tell me you do something that I understand at least half of it thanks
    this.noticeTarget.innerHTML = text;
  }

  determineWinner() {
    // Implement determineWinner logic
    let playerValue = this.calcHandValue(this.playerHand);
    let dealerValue = this.calcHandValue(this.dealerHand);
    this.showNotice();
    return `${playerValue > dealerValue ? "<em>You win!</em>" : "<em>Dealer Wins!</em>"}`;
  }

  hitDealer() {
    this.hiddenCardTarget.classList.remove('hidden-card');
    this.hiddenCardTarget.innerHTML = `<h6>${this.dealerHand[0]}</h6>`;
    let card = this.chooseRandomCard();
    this.dealerHand.push(card)

    let card_html = `<div class="my-card">${card}</div>`;
    this.dealersCardsTargets.push(card_html);

    let handValue = this.calcHandValue(this.dealerHand);
    if (handValue <= 16) {
        this.hitDealer();
    } else if (handValue === 21) {
        this.showNotice("Dealer has 21! Dealer wins!");
    }
    else if (handValue > 21) {
        this.showNotice("Dealer bust! You win!");
    }
    else {
        this.determineWinner();
    }
  }

  hitPlayer() {
    // Implement hitPlayer logic
    let card = this.chooseRandomCard();
    this.playerHand.push(card);
    let handValue = this.calcHandValue(this.playerHand);

    let card_html = `<div class="my-card">${card}</div>`;
    this.playersCardsTargets[0].insertAdjacentHTML('beforeend', card_html);

    if (handValue <= 21) {

    } else {
        let text = `Bust! Your hand is ${this.playerHand} with a value of ${handValue}.`;
        this.showNotice(text);
        // this.optionsTarget.classList.add('d-none')
        document.querySelectorAll('button').forEach((button) => {
          button.classList.toggle('d-none');
          // console.log(button);
        });
        console.log(this.dealersCardsTargets[0].querySelector('.hidden-card').classList.remove('hidden-card'));
        // this.dealersCardsTargets[0].classList.remove('hidden-card');
    }
    this.score();
  }

  clearHands() {
    // Implement clearHands logic
    // this.playersCardsTargets.innerHTML = "";
    // this.dealersCardsTargets.innerHTML = "";
    // Clear the inner HTML of each player card target
      this.playersCardsTargets.forEach((target) => {
        target.innerHTML = "";
      });


    // Clear the inner HTML of each dealer card target
      this.dealersCardsTargets.forEach((target) => {
        target.innerHTML = "";
      });

    console.log("clearHands");
    return true;
  }

  play() {
    // Implement play logic
    if(this.allDecks.length < 10) {
      this.shuffleDecks()
    }
    this.clearHands()

    let deal =  this.dealHands();
    this.dealerHand = deal.dealer;
    this.playerHand = deal.player;
    this.dealerHand.forEach((card, index) => {
      let card_html = `<div class="my-card">${card}</div>`;
      console.log(index);
        if(index == 0) {
          card_html = `<div class="my-card hidden-card">${card}</div>`;
        }
        this.dealersCardsTargets[0].insertAdjacentHTML('beforeend', card_html);
    })
    this.playerHand.forEach((card) => {
      let card_html = `<div class="my-card">${card}</div>`;
      this.playersCardsTargets[0].insertAdjacentHTML('beforeend', card_html);
      // this.playersCardsTargets.push(card_html);
    })
    // buttonContainer.style.display = "block"
    this.score();
  }

  replay() {
    document.querySelectorAll('button').forEach((button) => {
      button.classList.toggle('d-none');
      // console.log(button);
    })
    this.showNotice("Let's play!")
    this.play()
  }

  score() {
    this.scoreTarget.innerHTML = this.calcHandValue(this.playerHand);
  }


// I think we just get rid of this
  onNextHand() {
    this.play();
  }
}
