##########################################################################
# Copyright 2016 ThoughtWorks, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##########################################################################

module ApiV2
  module Admin
    class PluginInfosController < ApiV2::BaseController
      before_action :check_admin_user_or_group_admin_user_and_401

      def index
        plugin_infos = plugin_service.pluginInfos(params[:type])
        render DEFAULT_FORMAT => ApiV2::Plugin::PluginInfosRepresenter.new(plugin_infos).to_hash(url_builder: self)
      rescue InvalidPluginTypeException
        raise ApiV2::UnprocessableEntity, "Invalid plugins type - `#{params[:type]}` !"
      end

      def show
        plugin = plugin_service.pluginInfo(params[:id])

        raise RecordNotFound unless plugin

        render DEFAULT_FORMAT => ApiV2::Plugin::PluginInfoRepresenter.new(plugin).to_hash(url_builder: self)
      end
    end
  end
end
