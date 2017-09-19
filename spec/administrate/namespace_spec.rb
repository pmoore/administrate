require "rails_helper"
require "administrate/namespace"

describe Administrate::Namespace do
  describe "#resources" do
    let(:namespace) { Administrate::Namespace.new(:admin) }

    it "searches the routes for resources in the namespace" do
      begin
        Rails.application.routes.draw do
          namespace(:admin) { resources :customers }
        end

        expect(namespace.resources.map(&:to_sym)).to eq [:customers]
      ensure
        reset_routes
      end
    end

    it "does not include resources with prefix that equals namespace" do
      begin
        Rails.application.routes.draw do
          resources :admin_users
        end

        expect(namespace.resources.map(&:to_sym)).to eq []
      ensure
        reset_routes
      end
    end
  end
end
