class RatingForm extends React.Component {

  render() {

      let message;
      if (!this.props.ratingsExist) {
        message = <h4>Be the first to rate this run!</h4>;
      }
      else {
        message = <h4>Rate this run!</h4>;
      }


      return (
        <div>
          { message }
          <form onSubmit={this.props.addRating}>
            <div className='container'>
             <input type="radio" id="1" name="rating" value="1" required />
                <label htmlFor="1">1</label>

            <input type="radio" id="2" name="rating" value="2" required />
                <label htmlFor="2">2</label>

            <input type="radio" id="3" name="rating" value="3" required />
                <label htmlFor="3">3</label>

            <input type="radio" id="3" name="rating" value="4" required />
                <label htmlFor="4">4</label>

            <input type="radio" id="5" name="rating" value="5" required />
                <label htmlFor="5">5</label>
            </div>


              <div className="form-group">
                  <label for="comment">Comment:</label>
                  <textarea className="form-control" rows="5" id="description"></textarea>
              </div>
              <input className='btn' type='submit' />
          </form>
        </div>);
    
    
  
    
  }
}