import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../config/app_theme.dart';

class MPINScreen extends StatefulWidget {
  final String? phone;
  final bool isSetup;

  const MPINScreen({
    super.key,
    this.phone,
    this.isSetup = false,
  });

  @override
  State<MPINScreen> createState() => _MPINScreenState();
}

class _MPINScreenState extends State<MPINScreen> {
  final List<String> _pin = ['', '', '', ''];
  final List<String> _confirmPin = ['', '', '', ''];
  int _currentIndex = 0;
  bool _isConfirming = false;
  String? _errorMessage;

  void _onKeyTap(String value) {
    HapticFeedback.lightImpact();
    
    if (value == 'delete') {
      if (_currentIndex > 0) {
        setState(() {
          _currentIndex--;
          if (widget.isSetup && _isConfirming) {
            _confirmPin[_currentIndex] = '';
          } else {
            _pin[_currentIndex] = '';
          }
          _errorMessage = null;
        });
      }
      return;
    }

    if (_currentIndex < 4) {
      setState(() {
        if (widget.isSetup && _isConfirming) {
          _confirmPin[_currentIndex] = value;
        } else {
          _pin[_currentIndex] = value;
        }
        _currentIndex++;
        _errorMessage = null;
      });

      if (_currentIndex == 4) {
        _handlePinComplete();
      }
    }
  }

  void _handlePinComplete() {
    if (widget.isSetup) {
      if (!_isConfirming) {
        setState(() {
          _isConfirming = true;
          _currentIndex = 0;
        });
      } else {
        final pin = _pin.join();
        final confirmPin = _confirmPin.join();
        
        if (pin != confirmPin) {
          setState(() {
            _errorMessage = 'PINs do not match';
            _confirmPin.fillRange(0, 4, '');
            _currentIndex = 0;
          });
          HapticFeedback.heavyImpact();
          return;
        }
        context.go('/store');
      }
    } else {
      // Demo: accept any 4-digit PIN
      context.go('/store');
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayPin = widget.isSetup && _isConfirming ? _confirmPin : _pin;
    
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.navy),
          onPressed: () => context.go('/login'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                widget.isSetup
                    ? (_isConfirming ? 'Confirm MPIN' : 'Create MPIN')
                    : 'Enter MPIN',
                style: const TextStyle(
                  fontFamily: 'Playfair Display',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.navy,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.isSetup
                    ? (_isConfirming ? 'Re-enter your 4-digit MPIN' : 'Create a 4-digit MPIN')
                    : 'Enter your 4-digit MPIN',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  color: AppTheme.navy.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 48),
              // PIN Display
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  final isFilled = displayPin[index].isNotEmpty;
                  final isActive = index == _currentIndex;
                  
                  return Container(
                    width: 56,
                    height: 56,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isActive ? AppTheme.navy : AppTheme.navy.withOpacity(0.1),
                        width: isActive ? 2 : 1,
                      ),
                    ),
                    child: Center(
                      child: isFilled
                          ? Container(
                              width: 16,
                              height: 16,
                              decoration: const BoxDecoration(
                                color: AppTheme.navy,
                                shape: BoxShape.circle,
                              ),
                            )
                          : null,
                    ),
                  );
                }),
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: 24),
                Text(
                  _errorMessage!,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: AppTheme.error,
                    fontSize: 14,
                  ),
                ),
              ],
              const Spacer(),
              // Number Pad
              _buildNumberPad(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberPad() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['1', '2', '3'].map((e) => _buildKey(e)).toList(),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['4', '5', '6'].map((e) => _buildKey(e)).toList(),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['7', '8', '9'].map((e) => _buildKey(e)).toList(),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(width: 80),
            _buildKey('0'),
            _buildKey('delete', icon: Icons.backspace_outlined),
          ],
        ),
      ],
    );
  }

  Widget _buildKey(String value, {IconData? icon}) {
    return InkWell(
      onTap: () => _onKeyTap(value),
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: value == 'delete' ? Colors.transparent : Colors.white,
          border: value == 'delete' ? null : Border.all(color: AppTheme.navy.withOpacity(0.1)),
        ),
        child: Center(
          child: icon != null
              ? Icon(icon, color: AppTheme.navy)
              : Text(
                  value,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.navy,
                  ),
                ),
        ),
      ),
    );
  }
}
