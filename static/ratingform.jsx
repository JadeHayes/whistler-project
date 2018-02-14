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
            <div className='col-xs-6'>
            Rate this run: <br />
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
            <div className='col-xs-6'>
              Description:
              <br />
              <textarea className='input-lg resize' id='description' name='description' required>
                This run is awesome!
              </textarea>
              <input className='btn' type='submit' />
            </div>
          </form>
        </div>);
    
    
  
    
  }
}