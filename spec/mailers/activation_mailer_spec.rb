require "rails_helper"

RSpec.describe ActivationMailer, :type => :mailer do
  describe "ResetPasswordMailer" do
    let(:mail) { ActivationMailer.ResetPasswordMailer }

    it "renders the headers" do
      expect(mail.subject).to eq("Resetpasswordmailer")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
