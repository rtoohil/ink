module Octopress
  module Ink
    module Assets
      class DocPageAsset < Asset
        attr_reader :filename

        def initialize(plugin, base, file)
          @root = plugin.assets_path
          @plugin = plugin
          @base = base
          @filename = file
          @dir  = File.dirname(file)
          @file = File.basename(file)
          @exists = {}
          file_check
        end

        def path
          File.join(plugin_dir, page_dir, file)
        end
        
        # Add doc page to Jekyll pages
        #
        def add
          if Octopress.config['docs_mode']
            Octopress.site.pages << page
          end
        end

        private

        def page
          return @page if @page
          @page = Page.new(Octopress.site, source_dir, page_dir, file, {'path'=>plugin.docs_base_path})
          @page.data['layout'] = 'docs'
          @page.data['plugin'] = { 
            'name' => @plugin.name, 
            'slug' => @plugin.slug,
            'docs_base_path' => plugin.docs_base_path,
          }
          @page.data['dir'] = File.dirname(plugin_path)
          @page
        end

        def page_dir
          dir == '.' ? '' : dir
        end

        def plugin_path
          File.join(plugin_dir, page_dir, file)
        end

        def source_dir
          File.join root, base
        end

      end
    end
  end
end

