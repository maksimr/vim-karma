" @see http://whileimautomaton.net/2013/02/13211500
" Expect - https://github.com/kana/vim-vspec/blob/1.1.0/doc/vspec.txt#L104

source plugin/karma.vim
call vspec#hint({'scope': 'karma#scope()', 'sid': 'karma#sid()'})

describe 'karma.vim'
  it 'should return name of the plugin'
    Expect Ref('s:plugin_name') == 'vim-karma'
  end

  it 'should extract description from `it`'
      Expect Call('s:extractTestCaseContent', 'it', "it('test', function(){") == 'test'
  end

  it 'should extract description from `describe`'
      Expect Call('s:extractTestCaseContent', 'describe', "describe('test', function(){") == 'test'
  end
end
