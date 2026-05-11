#!/bin/bash

# =============================================================================
# Perforce Helper Script (p4s)
# Clean Code Version - Robert C. Martin Standard
# =============================================================================

# Cấu hình mặc định
DEFAULT_LIMIT=10

# --- CÁC HÀM TIỆN ÍCH (UTILITIES) ---
usage() {
    cat << EOF
Cách dùng: p4s [FLAG] [CLIENT/CL] [TARGET] [LIMIT]

Các chế độ:
  -s [client] [file]   : Tìm kiếm file trong client
  -S [client] [folder] : Tìm kiếm folder trong client
  -c [cl_number]       : Xem chi tiết Changelist (describe)

Ví dụ: p4s -s my_ws main.cpp 5
EOF
    exit 1
}

log_info() {
    echo "--- $1 ---"
}

# --- CÁC HÀM THỰC THI (COMMANDS) ---
# Mỗi hàm chỉ làm một nhiệm vụ duy nhất (SRP)

search_file() {
    local client=$1
    local file=$2
    local limit=${3:-$DEFAULT_LIMIT}

    [[ -z "$client" || -z "$file" ]] && usage
    log_info "Đang tìm file: $file trong client: $client"
    p4 -c "$client" files -m "$limit" "//$client/.../$file"
}

search_folder() {
    local client=$1
    local folder=$2
    local limit=${3:-$DEFAULT_LIMIT}

    [[ -z "$client" || -z "$folder" ]] && usage
    log_info "Đang tìm trong folder: $folder (client: $client)"
    p4 -c "$client" files -m "$limit" "//$client/.../$folder/..."
}

describe_cl() {
    local cl_number=$1
    [[ -z "$cl_number" ]] && { echo "Lỗi: Thiếu số CL"; usage; }
    
    log_info "Đang xem CL: $cl_number"
    p4 describe -S "$cl_number"
}

# --- PHẦN ĐIỀU PHỐI (ORCHESTRATOR) ---

main() {
    # Nếu không có tham số, hiển thị hướng dẫn
    [[ $# -eq 0 ]] && usage

    local mode=""
    local context_val=""

    # 1. Parse Flags (Sử dụng getopts để tách biệt logic lấy flag)
    while getopts "s:S:c:" opt; do
        case $opt in
            s) mode="FILE";   context_val="$OPTARG" ;;
            S) mode="FOLDER"; context_val="$OPTARG" ;;
            c) mode="DESC";   context_val="$OPTARG" ;;
            *) usage ;;
        esac
    done
    shift $((OPTIND-1))

    # 2. Execute dựa trên Mode (Áp dụng logic tương tự Strategy Pattern)
    case "$mode" in
        "FILE")
            search_file "$context_val" "$1" "$2"
            ;;
        "FOLDER")
            search_folder "$context_val" "$1" "$2"
            ;;
        "DESC")
            describe_cl "$context_val"
            ;;
        *)
            usage
            ;;
    esac
}

# Chạy script
main "$@"
