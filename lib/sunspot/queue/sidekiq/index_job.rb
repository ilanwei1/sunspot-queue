require "sidekiq/worker"
require "sunspot/queue/helpers"

module Sunspot::Queue::Sidekiq
  class IndexJob
    include ::Sunspot::Queue::Helpers
    include ::Sidekiq::Worker

    sidekiq_options :queue => "sunspot"

    def perform(klass, id,current_tenant)
      without_proxy do
        $current_tenant = current_tenant
        constantize(klass).find(id).solr_index
      end
    end
  end
end
