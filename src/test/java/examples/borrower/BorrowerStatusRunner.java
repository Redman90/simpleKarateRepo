package examples.borrower;

import com.intuit.karate.junit5.Karate;

class BorrowerStatusRunner {
    
    @Karate.Test
    Karate testBorrower() {
        return Karate.run("borrowerStatus").relativeTo(getClass());
    }    

}
