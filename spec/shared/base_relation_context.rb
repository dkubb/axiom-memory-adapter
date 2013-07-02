shared_context 'relation' do
  let(:relation)     { Relation.new(header, body)  }
  let(:body)         { [[1], [2], [3]]             }
  let(:header)       { [id_attribute]              }
  let(:id_attribute) { Attribute::Integer.new(:id) }
  let(:schema)       { {}                          }
  let(:name)         { 'users'.freeze              }
end
