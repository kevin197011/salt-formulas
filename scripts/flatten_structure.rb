#!/usr/bin/env ruby
# frozen_string_literal: true

# 将嵌套的目录结构扁平化
# 从 category/name/ 变为 category_name/

require 'fileutils'

SALT_FORMULAS_DIR = File.expand_path('..', __dir__)

# 需要处理的分类目录
CATEGORIES = %w[app base middleware runtime].freeze

def flatten_structure
  puts "开始扁平化目录结构..."
  puts "工作目录: #{SALT_FORMULAS_DIR}"
  puts

  moves = []

  CATEGORIES.each do |category|
    category_dir = File.join(SALT_FORMULAS_DIR, category)
    next unless File.directory?(category_dir)

    Dir.children(category_dir).each do |name|
      old_path = File.join(category_dir, name)
      next unless File.directory?(old_path)

      # 新名称: category_name (将 - 替换为 _ 以保持一致性)
      new_name = "#{category}_#{name.gsub('-', '_')}"
      new_path = File.join(SALT_FORMULAS_DIR, new_name)

      moves << { old: old_path, new: new_path, name: "#{category}/#{name}" }
    end
  end

  if moves.empty?
    puts "没有需要移动的目录"
    return
  end

  puts "将执行以下移动操作:"
  moves.each do |move|
    puts "  #{move[:name]} -> #{File.basename(move[:new])}"
  end
  puts

  # 执行移动
  moves.each do |move|
    if File.exist?(move[:new])
      puts "警告: 目标已存在，跳过: #{move[:new]}"
      next
    end

    FileUtils.mv(move[:old], move[:new])
    puts "已移动: #{move[:name]} -> #{File.basename(move[:new])}"
  end

  # 删除空的分类目录
  puts
  puts "清理空目录..."
  CATEGORIES.each do |category|
    category_dir = File.join(SALT_FORMULAS_DIR, category)
    next unless File.directory?(category_dir)

    if Dir.empty?(category_dir)
      FileUtils.rmdir(category_dir)
      puts "已删除空目录: #{category}/"
    else
      puts "目录非空，保留: #{category}/"
    end
  end

  puts
  puts "完成！"
end

flatten_structure if __FILE__ == $PROGRAM_NAME
