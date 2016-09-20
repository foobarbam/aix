# Author:: IBM Corporation
# Cookbook Name:: aix
# Provider:: volume_group
#
# Copyright:: 2016, International Business Machines Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Support whyrun
def whyrun_supported?
  true
end

def load_current_resource
  @volgroup = AIXLVM::VolumeGroup.new(@new_resource.name,AIXLVM::System.new())
  @volgroup.physical_volumes=@new_resource.physical_volumes
  @volgroup.use_as_hot_spare=@new_resource.use_as_hot_spare
end

action :create do
  begin
    if @volgroup.check_to_change()
      converge_by(@volgroup.create().join(" | ")) do

      end
    end
  rescue AIXLVM::LVMException => e
    Chef::Log.fatal(e.message)
  end
end

