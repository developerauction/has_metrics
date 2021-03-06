require "has_metrics/version"
require "has_metrics/metrics"
require "has_metrics/segmentation"
require "has_metrics/sql_capturer"

module HasMetrics
  def self.included(base)
    base.send :include, Metrics
    base.send :include, Segmentation

    if defined?(::NewRelic)
      base.send :include, ::NewRelic::Agent::Instrumentation::ControllerInstrumentation
      base.class_eval do
        class << self
          include ::NewRelic::Agent::Instrumentation::ControllerInstrumentation
          add_transaction_tracer :update_all_metrics!, category: :task
        end
      end
    end
  end
end