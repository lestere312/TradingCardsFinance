function deleteDeck(deckID){
  $.ajax({
    url: '/Deck/' + deckID,
    type: 'DELETE',
    success:function(result){
      window.location.reload(true);
    }
  })
};
    
