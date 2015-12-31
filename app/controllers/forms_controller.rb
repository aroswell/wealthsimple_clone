module Forms

  class KycController
    def self.new
      puts "new method called"
    end

    def self.create
      puts "creation time"

    end

    def self.edit
      puts "edit method called"

    end

    def self.update
      puts "Update in progress"

    end

  end

  class RiskAssessmentController
    def self.new
      puts "new risk form built"
    end

    def self.create
      puts "creation time for risk"
    end

    def self.edit
      puts "form rendered for editing"
    end

    def self.update
      puts "risk form updated"
    end
  end

  class SignFormsController
    def self.new
      puts "new documents received from VB API"
    end

    def self.create
      puts "sign form saved and emailed"
      # consider encrypted emails
    end

  end


end



